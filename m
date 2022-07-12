Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A627D571824
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiGLLK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiGLLKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:10:51 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36AA0B185D;
        Tue, 12 Jul 2022 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dEF2Q
        PRseg8+zbrj8wCk7YF3AJ+cA8X9usLdItYBsxo=; b=mIrwTueQwT/+OXYRIxUwr
        Xq74nxZn3zEFiAoRhuAJJvavl/ryjgV2dCf0E8oQCfypo8/O7qKsyTTdP7VCLhJg
        5iDETxgBW6hhpFwGyWu5XpPd48kXQZ+w2ezk8CNs2OlTCljFV+lIsVoZfY28/tBj
        PxjMvm15qeQeGaB4dunODo=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp8 (Coremail) with SMTP id DMCowADHIuFwVs1iMY2aMw--.18852S2;
        Tue, 12 Jul 2022 19:09:39 +0800 (CST)
From:   williamsukatube@163.com
To:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     miklos@szeredi.hu, William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH -next] ovl: Fix spelling mistakes and cleanup code
Date:   Tue, 12 Jul 2022 19:09:33 +0800
Message-Id: <20220712110933.2646293-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowADHIuFwVs1iMY2aMw--.18852S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfJw45Ar4kZrWrKF1fXFy7Jrb_yoWkAFyDpa
        yYyaykKr4rXry7Wr1IyF4DZ3WS934vgFW7Jry8WwnYyF9aqrZIqFy7tFyjvryrJFy8W3yS
        qa1jkr15Gw4UKw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j_189UUUUU=
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbBSRk8g1aEEIOqOgAAs+
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

First, fix follow spelling misktakes:
	decendant  ==> descendant
	indentify  ==> identify
Second, delete extra blank line and add blank line where
appropriate to make code format more standardized.

Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 fs/overlayfs/copy_up.c |  4 ++++
 fs/overlayfs/dir.c     |  8 ++++++++
 fs/overlayfs/inode.c   |  5 ++++-
 fs/overlayfs/namei.c   |  7 +++++--
 fs/overlayfs/readdir.c |  8 ++++++--
 fs/overlayfs/super.c   | 10 ++++++----
 fs/overlayfs/util.c    |  8 ++++++--
 7 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 714ec569d25b..9c515ad05a70 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -127,6 +127,7 @@ int ovl_copy_xattr(struct super_block *sb, struct path *oldpath, struct dentry *
 		}
 	}
 	kvfree(value);
+
 out:
 	kvfree(buf);
 	return error;
@@ -283,6 +284,7 @@ static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
 
 		len -= bytes;
 	}
+
 out:
 	if (!error && ovl_should_sync(ofs))
 		error = vfs_fsync(new_file, 0);
@@ -493,6 +495,7 @@ static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
 		err = ovl_do_rename(ofs, dir, temp, dir, index, 0);
 		dput(index);
 	}
+
 out:
 	if (err)
 		ovl_cleanup(ofs, dir, temp);
@@ -893,6 +896,7 @@ static ssize_t ovl_getxattr_value(struct path *path, char *name, char **value)
 		else
 			*value = buf;
 	}
+
 	return res;
 }
 
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 6b03457f72bb..d8cee9686cb3 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -101,6 +101,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 	}
 	whiteout = ofs->whiteout;
 	ofs->whiteout = NULL;
+
 out:
 	return whiteout;
 }
@@ -454,6 +455,7 @@ static int ovl_set_upper_acl(struct ovl_fs *ofs, struct dentry *upperdentry,
 		goto out_free;
 
 	err = ovl_do_setxattr(ofs, upperdentry, name, buffer, size, XATTR_CREATE);
+
 out_free:
 	kfree(buffer);
 	return err;
@@ -551,6 +553,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		ovl_cleanup(ofs, udir, newdentry);
 		dput(newdentry);
 	}
+
 out_dput:
 	dput(upper);
 out_unlock:
@@ -614,6 +617,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		else
 			err = ovl_create_over_whiteout(dentry, inode, attr);
 	}
+
 out_revert_creds:
 	revert_creds(old_cred);
 	return err;
@@ -843,6 +847,7 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
 	 */
 	if (!err)
 		d_drop(dentry);
+
 out_dput_upper:
 	dput(upper);
 out_unlock:
@@ -1012,6 +1017,7 @@ static char *ovl_get_redirect(struct dentry *dentry, bool abs_redirect)
 		buf[buflen] = '/';
 	}
 	ret = kstrdup(&buf[buflen], GFP_KERNEL);
+
 out_put:
 	dput(d);
 	kfree(buf);
@@ -1043,6 +1049,7 @@ static bool ovl_need_absolute_redirect(struct dentry *dentry, bool samedir)
 	 * redirect.
 	 */
 	lowerdentry = ovl_dentry_lower(dentry);
+
 	return (d_inode(lowerdentry)->i_nlink > 1);
 }
 
@@ -1074,6 +1081,7 @@ static int ovl_set_redirect(struct dentry *dentry, bool samedir)
 		/* Fall back to userspace copy-up */
 		err = -EXDEV;
 	}
+
 	return err;
 }
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 492eddeb481f..1969488b2a01 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -16,7 +16,6 @@
 #include <linux/namei.h>
 #include "overlayfs.h"
 
-
 int ovl_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct iattr *attr)
 {
@@ -87,6 +86,7 @@ int ovl_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		if (winode)
 			put_write_access(winode);
 	}
+
 out_drop_write:
 	ovl_drop_write(dentry);
 out:
@@ -487,6 +487,7 @@ int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
 			inode->i_atime = d_inode(upperpath.dentry)->i_atime;
 		}
 	}
+
 	return 0;
 }
 
@@ -589,6 +590,7 @@ int ovl_fileattr_set(struct user_namespace *mnt_userns,
 		ovl_copyattr(inode);
 	}
 	ovl_drop_write(dentry);
+
 out:
 	return err;
 }
@@ -620,6 +622,7 @@ int ovl_real_fileattr_get(struct path *realpath, struct fileattr *fa)
 	err = vfs_fileattr_get(realpath->dentry, fa);
 	if (err == -ENOIOCTLCMD)
 		err = -ENOTTY;
+
 	return err;
 }
 
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 65c4346a5b43..42ab6efca264 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -42,7 +42,7 @@ static int ovl_check_redirect(struct path *path, struct ovl_lookup_data *d,
 		 * One of the ancestor path elements in an absolute path
 		 * lookup in ovl_lookup_layer() could have been opaque and
 		 * that will stop further lookup in lower layers (d->stop=true)
-		 * But we have found an absolute redirect in decendant path
+		 * But we have found an absolute redirect in descendant path
 		 * element and that should force continue lookup in lower
 		 * layers (reset d->stop).
 		 */
@@ -217,6 +217,7 @@ static struct dentry *ovl_lookup_positive_unlocked(struct ovl_lookup_data *d,
 		dput(ret);
 		ret = ERR_PTR(-ENOENT);
 	}
+
 	return ret;
 }
 
@@ -294,6 +295,7 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 	err = ovl_check_redirect(&path, d, prelen, post);
 	if (err)
 		goto out_err;
+
 out:
 	*ret = this;
 	return 0;
@@ -345,6 +347,7 @@ static int ovl_lookup_layer(struct dentry *base, struct ovl_lookup_data *d,
 		if (WARN_ON(rem >= d->name.len))
 			return -EIO;
 	}
+
 	*ret = dentry;
 	return 0;
 }
@@ -648,7 +651,7 @@ static int ovl_get_index_name_fh(struct ovl_fh *fh, struct qstr *name)
  * If the index dentry for a copy up origin inode is positive, but points
  * to an inode different than the upper inode, then either the upper inode
  * has been copied up and not indexed or it was indexed, but since then
- * index dir was cleared. Either way, that index cannot be used to indentify
+ * index dir was cleared. Either way, that index cannot be used to identify
  * the overlay inode.
  */
 int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 78f62cc1797b..4719afdff082 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -167,6 +167,7 @@ static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
 		p->next_maybe_whiteout = rdd->first_maybe_whiteout;
 		rdd->first_maybe_whiteout = p;
 	}
+
 	return p;
 }
 
@@ -373,6 +374,7 @@ static int ovl_dir_read_merged(struct dentry *dentry, struct list_head *list,
 			list_del(&rdd.middle);
 		}
 	}
+
 	return err;
 }
 
@@ -589,6 +591,7 @@ static int ovl_dir_read_impure(struct path *path,  struct list_head *list,
 			rb_insert_color(&p->node, root);
 		}
 	}
+
 	return 0;
 }
 
@@ -788,6 +791,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		ctx->pos++;
 	}
 	err = 0;
+
 out:
 	revert_creds(old_cred);
 	return err;
@@ -827,9 +831,9 @@ static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 		}
 		res = offset;
 	}
+
 out_unlock:
 	inode_unlock(file_inode(file));
-
 	return res;
 }
 
@@ -855,7 +859,6 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
  */
 struct file *ovl_dir_real_file(const struct file *file, bool want_upper)
 {
-
 	struct ovl_dir_file *od = file->private_data;
 	struct dentry *dentry = file->f_path.dentry;
 	struct file *old, *realfile = od->realfile;
@@ -1123,6 +1126,7 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, struct path *path,
 			break;
 	}
 	inode_unlock(dir);
+
 out:
 	ovl_cache_free(&list);
 	return err;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e0a2e0468ee7..b936e2c9226b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -21,7 +21,6 @@ MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Overlay filesystem");
 MODULE_LICENSE("GPL");
 
-
 struct ovl_dir_cache;
 
 #define OVL_MAX_STACK 500
@@ -131,6 +130,7 @@ static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak)
 			ret = -ESTALE;
 		}
 	}
+
 	return ret;
 }
 
@@ -150,6 +150,7 @@ static int ovl_dentry_revalidate_common(struct dentry *dentry,
 		ret = ovl_revalidate_real(oe->lowerstack[i].dentry, flags,
 					  weak);
 	}
+
 	return ret;
 }
 
@@ -910,8 +911,8 @@ static int ovl_check_namelen(struct path *path, struct ovl_fs *ofs,
 			     const char *name)
 {
 	struct kstatfs statfs;
-	int err = vfs_statfs(path, &statfs);
 
+	int err = vfs_statfs(path, &statfs);
 	if (err)
 		pr_err("statfs failed on '%s'\n", name);
 	else
@@ -1024,6 +1025,7 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 	}
+
 	err = -EOPNOTSUPP;
 	if (!IS_POSIXACL(d_inode(workdir)))
 		goto out_acl_release;
@@ -1033,6 +1035,7 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 		err = acl ? -EACCES : 0;
 		goto out_acl_release;
 	}
+
 	err = -EPERM;
 	if (!inode_owner_or_capable(&init_user_ns, inode))
 		goto out_acl_release;
@@ -1397,7 +1400,6 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 	else
 		pr_warn("upper fs does not support tmpfile.\n");
 
-
 	/* Check if upper/work fs supports RENAME_WHITEOUT */
 	err = ovl_check_rename_whiteout(ofs);
 	if (err < 0)
@@ -1619,6 +1621,7 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
 			return false;
 		}
 	}
+
 	return true;
 }
 
@@ -1880,7 +1883,6 @@ static int ovl_check_layer(struct super_block *sb, struct ovl_fs *ofs,
 	}
 
 	dput(parent);
-
 	return err;
 }
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 87f811c089e4..b949e2080b43 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -19,6 +19,7 @@
 int ovl_want_write(struct dentry *dentry)
 {
 	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
+
 	return mnt_want_write(ovl_upper_mnt(ofs));
 }
 
@@ -31,6 +32,7 @@ void ovl_drop_write(struct dentry *dentry)
 struct dentry *ovl_workdir(struct dentry *dentry)
 {
 	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
+
 	return ofs->workdir;
 }
 
@@ -147,6 +149,7 @@ enum ovl_path_type ovl_path_type(struct dentry *dentry)
 		if (oe->numlower > 1)
 			type |= __OVL_PATH_MERGE;
 	}
+
 	return type;
 }
 
@@ -375,6 +378,7 @@ bool ovl_has_upperdata(struct inode *inode)
 
 	if (!ovl_test_flag(OVL_UPPERDATA, inode))
 		return false;
+
 	/*
 	 * Pairs with smp_wmb() in ovl_set_upperdata(). Main user of
 	 * ovl_has_upperdata() is ovl_copy_up_meta_inode_data(). Make sure
@@ -583,7 +587,6 @@ bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, struct path *path)
 	int res;
 
 	res = ovl_path_getxattr(ofs, path, OVL_XATTR_ORIGIN, NULL, 0);
-
 	/* Zero size value means "copied up but origin unknown" */
 	if (res >= 0)
 		return true;
@@ -641,7 +644,6 @@ int ovl_check_setxattr(struct ovl_fs *ofs, struct dentry *upperdentry,
 		return xerr;
 
 	err = ovl_setxattr(ofs, upperdentry, ox, value, size);
-
 	if (err == -EOPNOTSUPP) {
 		pr_warn("cannot set %s xattr on upper\n", ovl_xattr(ofs, ox));
 		ofs->noxattr = true;
@@ -994,6 +996,7 @@ int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct path *path)
 	}
 
 	return 1;
+
 out:
 	pr_warn_ratelimited("failed to get metacopy (%i)\n", res);
 	return res;
@@ -1050,6 +1053,7 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct path *path, int padding)
 	}
 
 	return buf;
+
 invalid:
 	pr_warn_ratelimited("invalid redirect (%s)\n", buf);
 	res = -EINVAL;
-- 
2.25.1

