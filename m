Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4DB55E323
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbiF1BJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239116AbiF1BI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:08:59 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB553222BC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378536; bh=2BLP2lKCc65T4YclFQ8fkaJyAWYAAdNnAEMDMhWmqR4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=G+0qbpzGjYje6U3hwo37dAUSuNMueAy82KWZOL8lXjuolmuX3gKT+SqnldskNgZYzVWH2FIQGphS4C2C4tdvn5dLg9y6PobYgtSpsoYmAGnw2sGFwTdTcS8jyqfLAFHJZgA6LHNdliMa25ZRjUU6TBc6XcalkRgiVqGUiQfteSAjNfiS16bBrD80KdMOvaJqaFYsr8euNtKNj3g/63wfsfLIyT/3rua7GSasvaH3FN+Aq0QBk3Of7RqJxVODp0RtyFRGZm6o0i4UVz2EoWCil0+mnXHNr8vAy+M4haEE/nk8Sde2/AwvvWsZdV1GUjP5YREPEmjii4tMh9cd0ILjtQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378536; bh=OvP9LME0ZZlm/rcZrVMZKCS1mxxf1EM/MpmHcB6JhcM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cESsEISjyunUT7/Uo3Ajd8IPin5YRw+AQggOKGPNGpHnnKPV3TpsNJu2IttemFhMvJpQoXSekJiKNNbgug6MHiPBDCMCrGGx2aSy+hv4cb5f6hMN11P3QHMzv5RsgiGccPoWhDdNmQrWlsah+iOxI0ISeYQou/Ct39j15hZ0lLwdhLkH+swz4b0LKf9tsXpjt/oIpqUdIXu391yDBH9mqI1/O8TQxy/1zZSymiH0Puoz2yXO3LboiAhwd6xo8EBx9uyjJtGeOxaDxxwlVncJuAV8B2fTvkpqv09UtMWG79kKYUd5CcTbcRxj5MAhivknVG9/CoBNRy4Nxu9vUn7tJg==
X-YMail-OSG: uvyxhgwVM1lTW7SNA_CSfK3ZBA7gE4fUlCoahqyuqMbo18mMZkt0AxoOlrj5Zmu
 td2GNaT_OREm2efGNMF5P9oXu2FCLXG6kPU_PU7.xYw4926WSAc6xktg5mIiPfmqzachdNZGGiZc
 1kMIUm61DAtcCLa2zvCzB61QkJlRNEHRLvj02zw7lSz9F.HBn9Lk4j6y03rkJLIuN5xQ7_73st4Q
 s8kNt7u0WkQ0Nvu5qloLqkSj4eVHg.tywP6SgxWKpFMfNd.KNadBw4i9PRUWf15Ms7OQkGV.NAul
 EywSPbpAMYQxiKQAAgfMKDgwUPdkluueiAYdRfLwsZDM7r0M5i1pZDFG_JG9iN9OBVLGToHX93kc
 bEHdUlfL7FGHo.Bbg7a4dQ8O6_Jv2XhBmW37z_4vxXt1Li.yhpPpCHZK.2I2SfLKz9l1zJtjfTEC
 Dsv2NAXNc6RieNAzhV2g38AG39N_090eH9Vr58ttkPQscRwRm90d.lWBaRhlOZNw.TMUezSDUwnr
 tLujZvBbE7Lwzj3aF_VSySelr02EKGC0OMkIloGHk8nWQBJwfsRCnHPdO7lrVm3tAdvI3dp2RaZ1
 bUmp6c3354hWtDQIsOyGZ7SKKaHqHdGbNeKYaIFclYd9wJAvqW6SFL8pNfsoJL6Uh_JUuBCcnzU0
 BmJ6wsj0yz9aDD0cpHo7zIwes68HoxtzIDOFY9a2kk7c.ja9WzWJpsq4z64viU3gonfNdHytxRDS
 0ZjFFt87G5_rOV_xTloE_CoCkH.c6MS7erNMGJYPH9wq8Lc0sZQxZIXbRt7RgCRLhuJUMH2j.7PV
 O.nWz8.qQpFWDbIs6ot3O1zcOfsETu2i1h12VjSjKSjOXSh36MaQL_eWcqih0oLJaffZD8cUDCU_
 xPQOv3t6TtUVuMJnE7NzRUqB_nkydzvmj059vYIkQ2vE7U4eKjCReWc_um0P38t8a4HCxMGUdBC3
 0WsRkuSaFc2Y8s3xlUCz5uSMz7JOPvifPbBC5r_Kasx2cV0QuV3scgUJwTNn.U0cBuU43bLtdtiK
 7B6YupvrwrBhNOWqPMfmP4ILH72ArL.htpNsRHeYRmSlW9XksGu3_CMYzlYtlxAZFjzl5bfRzUjO
 bQG_CacgeDhkJEhwOZ3o_d3CdgfQCJWOb7WJYwId.ORrwqkjx4G7Eh.Hp6oBv5g.VDNLXW3UfJ2l
 mqzz6fOFk7LTYH_vQoflxpuS15SpzTlSTnD8bJi0mcni7gI4WzXprJqfQiVVfyl9Dm.17NPI4niK
 Xs3thWefglx5nP22fad_WdqbYjJ_hL3Y3kpLMLVH_kV2Biu3XjgTAVXvYJP8_Pw0YuU3dzYUvPuZ
 TJERBRoYVVHhXW.dfAkpD2dJdv2V5mBhUj0DPICq784NYdQiYShyUrtPhENqPTjAwnCcvrkly3Gj
 8_cNkGBrLCzMrdReqqvSfWRXyWoffFe3ZnbtKGjpkaKHAU3mRgadMQV4nKhdWUYLC8TDjDrlFvQO
 gGVgsB5Ezb5w1JRsHOu4_xFnmfNTWK.gbZXGLNI77ItHyEIOyVw5o0FOuUzrBImOwsaEaYjlInou
 fzd6O4f_EJi5lM.whDRK2H1NOSOH0Dt0p7G5CXgCFImwzYJYk3ofhwj1fK.dcWpvGYTF0H2luYns
 01ZDAI5gO7RDgSwok9d6tAK7JFjo0YNN78vNNpK_o6o_q5Zm8vekuwgIrr2fggJMDrVXKtqhquRh
 9nCxu53nYPnP.zQyiyp65WMzLRNw16JIk4rPgSYNb3hp4ibDkuLUqGFJsxGwNpM8vp2NE.wA6qqn
 RRdxtXbWtHomxWHa5NxaGPtAIBNT5R_kHVz44Oo1NmGiEGUSx0sZs2iB.kKKknLbIliEgpMCMc3Q
 lEzDKQ21ZTo.6tqcfJqMdHq6cPdftCj1bNXuBEK9Y0M9F2nCVPU_C4FQH4ab9_O6i8MiQQx.oAER
 kD2LjcL6VkT8rAVchV00DvjpTcm65slW1vyhaHGUqZ.q6Rj47oP4RZTpY1j9zG3yRn6UYNRBtYtj
 jA5sWcqMt5jc.JU4aXqNCAZgdZfcs1qUgEpXFBQen_lQtMG1rN17pBQ8hS2cKLNIdp.aCsy.xyj0
 jal86orAhotdkMzXrsMPb4_tp4UgssqIzZ5ry32NCZLoVtJ4cH_kp9u_4AdJ4j9vDNAp9CXD1C4W
 0nEN6CK9PhSH8wBbTewrhhqt9jrBoajyuvGnUjuH7xuPxpp5H_ARaf.k_gPPEb5_JEu8j.j2f9vq
 dXVTqkRZWiSA8thmsaFUWk4VqhGJsK0kQMnvq_rkxLuLQ1eyuE6GSvqpX
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:08:56 +0000
Received: by hermes--production-bf1-7f5f59bd5b-fj9wt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 05fbaa230dcbeea0318fe174d0a2d20b;
          Tue, 28 Jun 2022 01:08:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 18/33] LSM: Use lsmcontext in security_dentry_init_security
Date:   Mon, 27 Jun 2022 17:55:56 -0700
Message-Id: <20220628005611.13106-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 fs/fuse/dir.c            | 35 ++++++++++++++++++-----------------
 fs/nfs/dir.c             |  2 +-
 fs/nfs/inode.c           | 17 ++++++++++-------
 fs/nfs/internal.h        |  8 +++++---
 fs/nfs/nfs4proc.c        | 20 ++++++++------------
 fs/nfs/nfs4xdr.c         | 22 ++++++++++++----------
 include/linux/nfs4.h     |  8 ++++----
 include/linux/nfs_fs.h   |  2 +-
 include/linux/security.h | 18 ++++++++++++++----
 security/security.c      | 26 +++++++++++++++++++-------
 12 files changed, 99 insertions(+), 81 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index f59dac66955b..e76967c7b69c 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1059,8 +1059,7 @@ struct ceph_acl_sec_ctx {
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
index 4c4dad4713b6..0068ee3bd13a 100644
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
index 74303d6e987b..ede296af6898 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -464,29 +464,29 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 {
 	struct fuse_secctx *fctx;
 	struct fuse_secctx_header *header;
-	void *ctx = NULL, *ptr;
-	u32 ctxlen, total_len = sizeof(*header);
+	struct lsmcontext lsmctx = { };
+	void *ptr;
+	u32 total_len = sizeof(*header);
 	int err, nr_ctx = 0;
-	const char *name;
+	const char *name = NULL;
 	size_t namelen;
 
 	err = security_dentry_init_security(entry, mode, &entry->d_name,
-					    &name, &ctx, &ctxlen);
-	if (err) {
-		if (err != -EOPNOTSUPP)
-			goto out_err;
-		/* No LSM is supporting this security hook. Ignore error */
-		ctxlen = 0;
-		ctx = NULL;
-	}
+					    &name, &lsmctx);
+
+	/* If no LSM is supporting this security hook ignore error */
+	if (err && err != -EOPNOTSUPP)
+		goto out_err;
 
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
@@ -499,19 +499,20 @@ static int get_security_context(struct dentry *entry, umode_t mode,
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
index 0c4e8dd6aa96..861d23eeac6e 100644
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
index ca2ed1909608..a4d08b47cbc3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -229,8 +229,19 @@ static inline bool lsmblob_equal(const struct lsmblob *bloba,
 }
 
 /* Map lsm names to blob slot numbers */
+#if LSMBLOB_ENTRIES > 0
 extern int lsm_name_to_slot(char *name);
 extern const char *lsm_slot_to_name(int slot);
+#else
+static inline int lsm_name_to_slot(char *name)
+{
+	return LSMBLOB_INVALID;
+}
+static inline const char *lsm_slot_to_name(int slot)
+{
+	return NULL;
+}
+#endif
 
 /**
  * lsmblob_value - find the first non-zero value in an lsmblob structure.
@@ -470,8 +481,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
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
@@ -888,8 +899,7 @@ static inline int security_dentry_init_security(struct dentry *dentry,
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
index 72df3d0cd233..96a89fd5802b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -487,6 +487,8 @@ static int lsm_append(const char *new, char **result)
  * Current index to use while initializing the lsmblob secid list.
  */
 static int lsm_slot __lsm_ro_after_init;
+
+#if LSMBLOB_ENTRIES > 0
 static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
 
 /**
@@ -531,6 +533,7 @@ const char *lsm_slot_to_name(int slot)
 		return NULL;
 	return lsm_slotlist[slot]->lsm;
 }
+#endif /* LSMBLOB_ENTRIES > 0 */
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -549,6 +552,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 
 	WARN_ON(!lsmid->slot || !lsmid->lsm);
 
+#if LSMBLOB_ENTRIES > 0
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
@@ -557,6 +561,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
 	}
+#endif /* LSMBLOB_ENTRIES > 0 */
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
@@ -1167,8 +1172,8 @@ void security_inode_free(struct inode *inode)
 
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
-				  const char **xattr_name, void **ctx,
-				  u32 *ctxlen)
+				  const char **xattr_name,
+				  struct lsmcontext *lsmctx)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -1176,9 +1181,13 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
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
@@ -2238,7 +2247,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 		ilsm = lsm_task_ilsm(p);
 		if (ilsm != LSMBLOB_INVALID)
 			slot = ilsm;
-		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
+		*value = kstrdup(lsm_slot_to_name(slot), GFP_KERNEL);
 		if (*value)
 			return strlen(*value);
 		return -ENOMEM;
@@ -2273,6 +2282,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
 	struct security_hook_list *hp;
+	const char *slotname;
 	char *termed;
 	char *copy;
 	int *ilsm = current->security;
@@ -2304,12 +2314,14 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 
 		termed = strsep(&copy, " \n");
 
-		for (slot = 0; slot < lsm_slot; slot++)
+		for (slot = 0; slot < lsm_slot; slot++) {
+			slotname = lsm_slot_to_name(slot);
 			if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
-				*ilsm = lsm_slotlist[slot]->slot;
+				*ilsm = slot;
 				rc = size;
 				break;
 			}
+		}
 
 		kfree(termed);
 		return rc;
-- 
2.36.1

