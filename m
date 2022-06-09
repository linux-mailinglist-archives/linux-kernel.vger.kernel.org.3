Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCAC545824
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345937AbiFIXLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiFIXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:11:42 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B1103D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816299; bh=M/LeK5Kfm6wj3vunO6NInuhA53/rJWI8+99xawwYlZs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VbE082OhNAcFiGaXG04XXUkIAU/V5mAhtApJnTVs0+mbpb6whHcwkwd9SZJo7eeoWAyXyLyfNiAtvR9dHO6B7PySo96vHA1bbkkIm/WtJQOs/2wrTmrVVZMW98xo3e7dCjLcTE+PaYr+enOUeoAkwDNebCq6IogogsV3HuKcws9pCgeVwlSNybuuf0ZuzC61Adgw50TM7DxwF/pmrwUTioRKTIkAd/jNq9KkGVvexgPs5M9OiCL5ytC+nQnDg6Hyr+6+MHxt87HL3+ClH5T5oEmneYDjULv1Hx+PKAWeF8y326Dz708Q126pd0p+IiLCXUyYLtcjc6Lv1K5qU/b2XA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816299; bh=FScgEPpruFHdm1EzRS3/Pz7nwHzmEVfivpkFBf5uGIm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=d3xLoaI48yQQUSuDxQ4kPzFa/LkMWRvccsWdZp2wUSm1gU1oiZU6QD3KjW5O7EsQoNkT/qF1TQ61MdyMZMaFeRv7PcyASuetTPuTR+p4iL982tFHaZvw9raNp1G3IiDUGrgHDwbt3qSQUUKSfqnpnOH8nhxQfb+UQgHBZ7Z7N6lRL6sBDyjnrY8EaWEop4w6YS3XX7ZRk/w/XhnSoksWg1UN5loS2d+4bwTbw58G2iZzXwd1BJ119rndREUDwSTDzrxJ15l2yPoU/NoVO4oNNF4aQWw+jZs7hQdj9A8p95zZ8c/qHlSX0jUEnmzXbaGCGqFy7qp3zTU+CIIUIRz8Fw==
X-YMail-OSG: VMDJMOYVM1nFao03hYE_02NTU431iRVjXwrJ9Ue5LZUMGgOqrkCWieXGzlMbjbV
 7IOhPx.8Njtn6_ibaSutVenPVa8yYbX1fbOOJUYQpK4geir7kV1SwaQfWc22WLqgMw2WwTnbaruN
 ZaEBWytNrbX_RF3SbfjnqSOq9Mid1lP8dIB9XZNm.3hng_6iYkIaLnALF3T5oOI7lPgKcjGk7PVa
 iHHiLZODvRYwqPhpcQSpRv4n2pDz16vdh4TSeCyQdjNlV2P_VIg0A.uZRU42irgY389ErsWK26Ob
 h6BPXXRWIgAEPhPuDUm23HWFwbdvYg8mA_ciqOwIYtkyMYyD30oH412D0f5dZua74XRBXJG4kWwW
 ukBzTcuZwPvLbgCoRIxfuDgtw4XKYhJMwW.nXM8QTqfOvhJfMFLAxRkHUfft2fpd5uMaXnA7c305
 8EBjFKSlz_lFXrS0HaEYgZfallfGOM4Y2mcvi92eBVTTgsq1Cbv0QGZOIn0CNy4grxy80InUt6y1
 Vf0eH7yjvK8peO_W4eUwRDWKkmzhDBIJ4OWd_TAiRC17OqzfQ_0Wrjv2S7O8wia5fQJMiICxMT.l
 qZJvUtN6kiYVYqriNVp_cJ_aPG5_0koGoyj6B.y.pXtl3mf__g6UTbvDWr3q30RG6L3KcJkwKIbo
 1qq9rOtGPA.c6C4_juDY4kO9pkPSTQ3VtyYP1TesFq_C8w8hu37KbJRnN49asTk00250CIvl7ueo
 qJ0b_SPbGVaf638RknXAtxa7x107tFevE9LfTmxD_xeZ5176rNp.yYshZhn96GiqWObYEwidKAJA
 l40CXwkctHq.GdNnnvC46kPnjZt3KpGN1rHkWpHjJxcew0hIYlp8C_duhemMZL8sP2gE6Oeio_PK
 VJQA_Gb.wa2XzTFSUHGXIiciB90moOXhRZtWfhjVvf887q9wHqclu350ahSYPsgsZQhOcJsvUzFI
 aAzkAtFsFH8UQfgWNn0XRrYgpSgKOY4KyYSzLMDDYMhDK86_nC4nKMyX8.i57Zxkbr_TPZvBrePD
 0zKHfNjPVjuJvlOMPUQoBR0awimvIt15N_K7LP6Xg_73qWNbtOrd3N4bJK2ji6T0Ctr3zpKDOpR1
 QEtvAXN5XqS.AUV_n7T8inkOI.d_Lw4MJCWFYmj4eKNrYBmYCKp87DCOn1NXoLyXWz0Ozk_DS_xU
 urof9IdVabQMYVqU1.Qa.sfxADVY4zirExDbvmWi1aIEdmJL7KshRTqF_oRNGUHlhzUnq.UxkYff
 6dbhl749w5wTSFK7mbna_hFCfuM9_lssm3zwwgCPzE1tr4RfNqjyUELrftnxHp6zQne29NIdFVMU
 VmBX7212b_Lasg.tpHaScYWDA0M4jv40XBH3I5QKRRcCHmdp1s3_PLV.e7SABn.tBvCwTksBwu_1
 1yXARb7A5rMlIhO1edQpNa37KyM88a1eVQPqvFhsY660RX8cuX2ryLUE.Q.i2F1rhiP5nNnnAghC
 xf9XBP7gk_V2vx2h6ZaA7wTEPHSisZiEDc_9rtRC2PPiwAdZuJYZ01ta9YRFkWb9aBOzzwUt7SCm
 dRV2aTzhC0ghl9gZvJuX1pqeQq.Gbz41JpvuccDM6VNLa9w1336JR.j_2YwKUpk56q_BdpHJu4k3
 FV2kI8bL_XK5CQzlxiaQjC44DQMz_CgmihgGSndw_jBXWiliVAMYvJaPfS0OTCSpIJlMdOHnapZy
 PQXGKuqfZCFInb7xUUh0dw2F4xxJ1MJHxGPXs6dqkysXRelBv88hLqYUz3csZ_zOGt3doEyyXnOh
 rAl6b6w6TfLzEqkdhx8yBv7CphmT87IAhgmuUayh.GxgNzOadP4SxedRFoLr3UUNcynnt0XHhq8O
 jt7uAObwRi_Uf9.BiIZBf.ldN0MjKeQ9.rPlwWk4CGhVLlzWliIbGemc6NjdsMG390XikNwFj1Xz
 zd0WUHM43cwFNj9DUl2v1Cz6dYbu.kDFzQcxLrb7dEHP80RQK..ynCyufFb3NOOmhE9NnK_n51qS
 WwVIhR_a0PhlogurRhx9ZF.MRupLgr92HpSb2s2lKytOg2dAxwdWcwjOImNlwQIEkpLNdejtPYKf
 v7eUPjz2L.gE32JQkaq0VaaxldaWIM9ZyKEfQAl7dO4XMF9SHJi4_BSvF12_luDrYb9iNLW04V8s
 AeqnQKmfQZ3AR0eEFAckDqGxACOpaIdrjoxS4iUoBsJwGW0IHuZn4ixaSLJrq5GbbFVKK90Ax2Nr
 3Sr9wlRx_UyR4R2js.n6SwoxYfCIxkOlziOKQxZX7knwJcqi8MxdPeT.Fu5UkISm4kA1EccqBioV
 BH.vUrgx5EqcRvTbxdxXmiheTiXu_kuaRqU9t2HssRrJaaLrFW5kE4l__C6g-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:11:39 +0000
Received: by hermes--canary-production-gq1-54945cc758-dgl4g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID df8474cdcb3bbd72743eb86b005fa96d;
          Thu, 09 Jun 2022 23:11:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 18/33] LSM: Use lsmcontext in security_dentry_init_security
Date:   Thu,  9 Jun 2022 16:01:31 -0700
Message-Id: <20220609230146.319210-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the (secctx,seclen) pointer pair with a single
lsmcontext pointer to allow return of the LSM identifier
along with the context and context length. This allows
security_release_secctx() to know how to release the
context. Callers have been modified to use or save the
returned data from the new structure.

Special care is taken in the NFS code, which uses the
same data structure for its own copied labels as it does
for the data which comes from security_dentry_init_security().
In the case of copied labels the data has to be freed, not
released.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/ceph/super.h          |  3 +--
 fs/ceph/xattr.c          | 19 ++++++-------------
 fs/fuse/dir.c            | 24 +++++++++++++-----------
 fs/nfs/dir.c             |  2 +-
 fs/nfs/inode.c           | 17 ++++++++++-------
 fs/nfs/internal.h        |  8 +++++---
 fs/nfs/nfs4proc.c        | 20 ++++++++------------
 fs/nfs/nfs4xdr.c         | 22 ++++++++++++----------
 include/linux/nfs4.h     |  8 ++++----
 include/linux/nfs_fs.h   |  2 +-
 include/linux/security.h |  7 +++----
 security/security.c      | 12 ++++++++----
 12 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index dd7dac0f984a..967bc060c7af 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1063,8 +1063,7 @@ struct ceph_acl_sec_ctx {
 	void *acl;
 #endif
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
-	void *sec_ctx;
-	u32 sec_ctxlen;
+	struct lsmcontext lsmctx;
 #endif
 	struct ceph_pagelist *pagelist;
 };
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index b1c81e75f37f..e761c6a151c9 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1328,8 +1328,7 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 	int err;
 
 	err = security_dentry_init_security(dentry, mode, &dentry->d_name,
-					    &name, &as_ctx->sec_ctx,
-					    &as_ctx->sec_ctxlen);
+					    &name, &as_ctx->lsmctx);
 	if (err < 0) {
 		WARN_ON_ONCE(err != -EOPNOTSUPP);
 		err = 0; /* do nothing */
@@ -1354,7 +1353,7 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 	 */
 	name_len = strlen(name);
 	err = ceph_pagelist_reserve(pagelist,
-				    4 * 2 + name_len + as_ctx->sec_ctxlen);
+				    4 * 2 + name_len + as_ctx->lsmctx.len);
 	if (err)
 		goto out;
 
@@ -1374,11 +1373,9 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 		as_ctx->pagelist = pagelist;
 	}
 
-	ceph_pagelist_encode_32(pagelist, name_len);
-	ceph_pagelist_append(pagelist, name, name_len);
-
-	ceph_pagelist_encode_32(pagelist, as_ctx->sec_ctxlen);
-	ceph_pagelist_append(pagelist, as_ctx->sec_ctx, as_ctx->sec_ctxlen);
+	ceph_pagelist_encode_32(pagelist, as_ctx->lsmctx.len);
+	ceph_pagelist_append(pagelist, as_ctx->lsmctx.context,
+			     as_ctx->lsmctx.len);
 
 	err = 0;
 out:
@@ -1391,16 +1388,12 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
 
 void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
 {
-#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
-	struct lsmcontext scaff; /* scaffolding */
-#endif
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 	posix_acl_release(as_ctx->acl);
 	posix_acl_release(as_ctx->default_acl);
 #endif
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
-	lsmcontext_init(&scaff, as_ctx->sec_ctx, as_ctx->sec_ctxlen, 0);
-	security_release_secctx(&scaff);
+	security_release_secctx(&as_ctx->lsmctx);
 #endif
 	if (as_ctx->pagelist)
 		ceph_pagelist_release(as_ctx->pagelist);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 74303d6e987b..632dfc3fd65b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -464,29 +464,30 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 {
 	struct fuse_secctx *fctx;
 	struct fuse_secctx_header *header;
-	void *ctx = NULL, *ptr;
-	u32 ctxlen, total_len = sizeof(*header);
+	struct lsmcontext lsmctx;
+	void *ptr;
+	u32 total_len = sizeof(*header);
 	int err, nr_ctx = 0;
 	const char *name;
 	size_t namelen;
 
 	err = security_dentry_init_security(entry, mode, &entry->d_name,
-					    &name, &ctx, &ctxlen);
+					    &name, &lsmctx);
 	if (err) {
 		if (err != -EOPNOTSUPP)
 			goto out_err;
 		/* No LSM is supporting this security hook. Ignore error */
-		ctxlen = 0;
-		ctx = NULL;
 	}
 
-	if (ctxlen) {
+	if (lsmctx.len) {
 		nr_ctx = 1;
 		namelen = strlen(name) + 1;
 		err = -EIO;
-		if (WARN_ON(namelen > XATTR_NAME_MAX + 1 || ctxlen > S32_MAX))
+		if (WARN_ON(namelen > XATTR_NAME_MAX + 1 ||
+		    lsmctx.len > S32_MAX))
 			goto out_err;
-		total_len += FUSE_REC_ALIGN(sizeof(*fctx) + namelen + ctxlen);
+		total_len += FUSE_REC_ALIGN(sizeof(*fctx) + namelen +
+					    lsmctx.len);
 	}
 
 	err = -ENOMEM;
@@ -499,19 +500,20 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 	ptr += sizeof(*header);
 	if (nr_ctx) {
 		fctx = ptr;
-		fctx->size = ctxlen;
+		fctx->size = lsmctx.len;
 		ptr += sizeof(*fctx);
 
 		strcpy(ptr, name);
 		ptr += namelen;
 
-		memcpy(ptr, ctx, ctxlen);
+		memcpy(ptr, lsmctx.context, lsmctx.len);
 	}
 	*security_ctxlen = total_len;
 	*security_ctx = header;
 	err = 0;
 out_err:
-	kfree(ctx);
+	if (nr_ctx)
+		security_release_secctx(&lsmctx);
 	return err;
 }
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a8ecdd527662..bdde5bcd2fa8 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -810,7 +810,7 @@ static int nfs_readdir_entry_decode(struct nfs_readdir_descriptor *desc,
 	int ret;
 
 	if (entry->fattr->label)
-		entry->fattr->label->len = NFS4_MAXLABELLEN;
+		entry->fattr->label->lsmctx.len = NFS4_MAXLABELLEN;
 	ret = xdr_decode(desc, entry, stream);
 	if (ret || !desc->plus)
 		return ret;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b4e46b0ffa2d..d3132f4626d0 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -361,14 +361,15 @@ void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr)
 		return;
 
 	if ((fattr->valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL) && inode->i_security) {
-		error = security_inode_notifysecctx(inode, fattr->label->label,
-				fattr->label->len);
+		error = security_inode_notifysecctx(inode,
+						fattr->label->lsmctx.context,
+						fattr->label->lsmctx.len);
 		if (error)
 			printk(KERN_ERR "%s() %s %d "
 					"security_inode_notifysecctx() %d\n",
 					__func__,
-					(char *)fattr->label->label,
-					fattr->label->len, error);
+					(char *)fattr->label->lsmctx.context,
+					fattr->label->lsmctx.len, error);
 		nfs_clear_label_invalid(inode);
 	}
 }
@@ -384,12 +385,14 @@ struct nfs4_label *nfs4_label_alloc(struct nfs_server *server, gfp_t flags)
 	if (label == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	label->label = kzalloc(NFS4_MAXLABELLEN, flags);
-	if (label->label == NULL) {
+	label->lsmctx.context = kzalloc(NFS4_MAXLABELLEN, flags);
+	if (label->lsmctx.context == NULL) {
 		kfree(label);
 		return ERR_PTR(-ENOMEM);
 	}
-	label->len = NFS4_MAXLABELLEN;
+	label->lsmctx.len = NFS4_MAXLABELLEN;
+	/* Use an invalid LSM slot as this should never be "released". */
+	label->lsmctx.slot = -1;
 
 	return label;
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 8f8cd6e2d4db..b97b66b8b7d0 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -342,13 +342,15 @@ nfs4_label_copy(struct nfs4_label *dst, struct nfs4_label *src)
 	if (!dst || !src)
 		return NULL;
 
-	if (src->len > NFS4_MAXLABELLEN)
+	if (src->lsmctx.len > NFS4_MAXLABELLEN)
 		return NULL;
 
 	dst->lfs = src->lfs;
 	dst->pi = src->pi;
-	dst->len = src->len;
-	memcpy(dst->label, src->label, src->len);
+	/* Use an invalid LSM slot as lsmctx should never be "released" */
+	dst->lsmctx.slot = -1;
+	dst->lsmctx.len = src->lsmctx.len;
+	memcpy(dst->lsmctx.context, src->lsmctx.context, src->lsmctx.len);
 
 	return dst;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d6bdb0868729..dca0d5c84337 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -123,8 +123,7 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, NULL,
-				(void **)&label->label, &label->len);
+				&dentry->d_name, NULL, &label->lsmctx);
 	if (err == 0)
 		return label;
 
@@ -133,12 +132,8 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 static inline void
 nfs4_label_release_security(struct nfs4_label *label)
 {
-	struct lsmcontext scaff; /* scaffolding */
-
-	if (label) {
-		lsmcontext_init(&scaff, label->label, label->len, 0);
-		security_release_secctx(&scaff);
-	}
+	if (label)
+		security_release_secctx(&label->lsmctx);
 }
 static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
 {
@@ -3800,7 +3795,7 @@ nfs4_atomic_open(struct inode *dir, struct nfs_open_context *ctx,
 		int open_flags, struct iattr *attr, int *opened)
 {
 	struct nfs4_state *state;
-	struct nfs4_label l = {0, 0, 0, NULL}, *label = NULL;
+	struct nfs4_label l = { }, *label = NULL;
 
 	label = nfs4_label_init_security(dir, ctx->dentry, attr, &l);
 
@@ -6108,7 +6103,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 					size_t buflen)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs4_label label = {0, 0, buflen, buf};
+	struct nfs4_label label = {0, 0, {buf, buflen, -1} };
 
 	u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
 	struct nfs_fattr fattr = {
@@ -6136,7 +6131,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 		return ret;
 	if (!(fattr.valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL))
 		return -ENOENT;
-	return label.len;
+	return label.lsmctx.len;
 }
 
 static int nfs4_get_security_label(struct inode *inode, void *buf,
@@ -6213,7 +6208,8 @@ static int nfs4_do_set_security_label(struct inode *inode,
 static int
 nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 {
-	struct nfs4_label ilabel = {0, 0, buflen, (char *)buf };
+	struct nfs4_label ilabel = {0, 0,
+				    {(char *)buf, buflen, -1}};
 	struct nfs_fattr *fattr;
 	int status;
 
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index acfe5f4bda48..9f1a376fb92c 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1154,7 +1154,7 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 	}
 
 	if (label && (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL)) {
-		len += 4 + 4 + 4 + (XDR_QUADLEN(label->len) << 2);
+		len += 4 + 4 + 4 + (XDR_QUADLEN(label->lsmctx.len) << 2);
 		bmval[2] |= FATTR4_WORD2_SECURITY_LABEL;
 	}
 
@@ -1186,8 +1186,9 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 	if (label && (bmval[2] & FATTR4_WORD2_SECURITY_LABEL)) {
 		*p++ = cpu_to_be32(label->lfs);
 		*p++ = cpu_to_be32(label->pi);
-		*p++ = cpu_to_be32(label->len);
-		p = xdr_encode_opaque_fixed(p, label->label, label->len);
+		*p++ = cpu_to_be32(label->lsmctx.len);
+		p = xdr_encode_opaque_fixed(p, label->lsmctx.context,
+					    label->lsmctx.len);
 	}
 	if (bmval[2] & FATTR4_WORD2_MODE_UMASK) {
 		*p++ = cpu_to_be32(iap->ia_mode & S_IALLUGO);
@@ -4236,12 +4237,12 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 			return -EIO;
 		if (len < NFS4_MAXLABELLEN) {
 			if (label) {
-				if (label->len) {
-					if (label->len < len)
+				if (label->lsmctx.len) {
+					if (label->lsmctx.len < len)
 						return -ERANGE;
-					memcpy(label->label, p, len);
+					memcpy(label->lsmctx.context, p, len);
 				}
-				label->len = len;
+				label->lsmctx.len = len;
 				label->pi = pi;
 				label->lfs = lfs;
 				status = NFS_ATTR_FATTR_V4_SECURITY_LABEL;
@@ -4250,10 +4251,11 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 		} else
 			printk(KERN_WARNING "%s: label too long (%u)!\n",
 					__func__, len);
-		if (label && label->label)
+		if (label && label->lsmctx.context)
 			dprintk("%s: label=%.*s, len=%d, PI=%d, LFS=%d\n",
-				__func__, label->len, (char *)label->label,
-				label->len, label->pi, label->lfs);
+				__func__, label->lsmctx.len,
+				(char *)label->lsmctx.context,
+				label->lsmctx.len, label->pi, label->lfs);
 	}
 	return status;
 }
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 8d04b6a5964c..5c2d69cf609a 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -15,6 +15,7 @@
 
 #include <linux/list.h>
 #include <linux/uidgid.h>
+#include <linux/security.h>
 #include <uapi/linux/nfs4.h>
 #include <linux/sunrpc/msg_prot.h>
 
@@ -44,10 +45,9 @@ struct nfs4_acl {
 #define NFS4_MAXLABELLEN	2048
 
 struct nfs4_label {
-	uint32_t	lfs;
-	uint32_t	pi;
-	u32		len;
-	char	*label;
+	uint32_t		lfs;
+	uint32_t		pi;
+	struct lsmcontext	lsmctx;
 };
 
 typedef struct { char data[NFS4_VERIFIER_SIZE]; } nfs4_verifier;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a17c337dbdf1..a838d4a45c1b 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -428,7 +428,7 @@ static inline void nfs4_label_free(struct nfs4_label *label)
 {
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	if (label) {
-		kfree(label->label);
+		kfree(label->lsmctx.context);
 		kfree(label);
 	}
 #endif
diff --git a/include/linux/security.h b/include/linux/security.h
index ca2ed1909608..1884c45f3d84 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -470,8 +470,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
-				  const char **xattr_name, void **ctx,
-				  u32 *ctxlen);
+				  const char **xattr_name,
+				  struct lsmcontext *lsmcxt);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -888,8 +888,7 @@ static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
 						 const char **xattr_name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsmcontext *lsmcxt)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 72df3d0cd233..a01967c66078 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1167,8 +1167,8 @@ void security_inode_free(struct inode *inode)
 
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
-				  const char **xattr_name, void **ctx,
-				  u32 *ctxlen)
+				  const char **xattr_name,
+				  struct lsmcontext *lsmctx)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -1176,9 +1176,13 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 	/*
 	 * Only one module will provide a security context.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security, list) {
+	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
+			     list) {
 		rc = hp->hook.dentry_init_security(dentry, mode, name,
-						   xattr_name, ctx, ctxlen);
+						   xattr_name,
+						   (void **)&lsmctx->context,
+						   &lsmctx->len);
+		lsmctx->slot = hp->lsmid->slot;
 		if (rc != LSM_RET_DEFAULT(dentry_init_security))
 			return rc;
 	}
-- 
2.35.1

