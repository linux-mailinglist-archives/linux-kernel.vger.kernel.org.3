Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4FD4D94E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbiCOG4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345304AbiCOG4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:56:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C89403DB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647327303; x=1678863303;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K4nJgs5xtwq4yKb4yM+G38J43n1l2K0izWthYKyK94E=;
  b=nyJPOEEyZzzaA/qvcfCDT5WYv838C3rorCiG2DQBwnKHKUv7JFlcMrJi
   yb5GqTx6G1VdVihRMJksAzYmizPtmd+Zf2tvgaHeq8I8Ybq7HpHSXovNm
   BHmKwfoD1HQ49pNddFVkw+YFFc4HadhhOWk/64dbQ4unR/QFBbRwvWKQ1
   fHx+nzjEgJwuVMf1S7OPCGaBbdeRI0y8RrhSzrfpSG+yDbG1Uh5cTw6iT
   16NCyUfuH0lJY1HTcQvS9/6COVDFDKRqAkW/6YbNrvRMXgnhyWrL6Ka6C
   rlCZj0uXbB4p4O71CJOGLJx8siu9IQ1huS9jNUbrw/cDpkYcZy8UsNNmG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236833187"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="236833187"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 23:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="646113955"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Mar 2022 23:54:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU158-000AfM-PB; Tue, 15 Mar 2022 06:54:58 +0000
Date:   Tue, 15 Mar 2022 14:54:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: [jlayton:ceph-fscrypt-sparse 66/74] fs/ceph/dir.c:424:10: error:
 implicit declaration of function 'ceph_encode_encrypted_dname'
Message-ID: <202203151450.7EtYHIru-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt-sparse
head:   0d355bda666e44314f11974167e8d9bb010a539e
commit: 4378b10dd7df64ef085e3fe2a2251034ee98c4dc [66/74] ceph: dencrypt the dentry names early and once for readdir
config: hexagon-randconfig-r012-20220313 (https://download.01.org/0day-ci/archive/20220315/202203151450.7EtYHIru-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=4378b10dd7df64ef085e3fe2a2251034ee98c4dc
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt-sparse
        git checkout 4378b10dd7df64ef085e3fe2a2251034ee98c4dc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/net/ethernet/mscc/ fs/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/ceph/dir.c:424:10: error: implicit declaration of function 'ceph_encode_encrypted_dname' [-Werror,-Wimplicit-function-declaration]
                           err = ceph_encode_encrypted_dname(inode, &d_name, req->r_path2);
                                 ^
   fs/ceph/dir.c:424:10: note: did you mean 'ceph_encode_encrypted_fname'?
   fs/ceph/crypto.h:175:19: note: 'ceph_encode_encrypted_fname' declared here
   static inline int ceph_encode_encrypted_fname(const struct inode *parent,
                     ^
   1 error generated.


vim +/ceph_encode_encrypted_dname +424 fs/ceph/dir.c

   307	
   308	static int ceph_readdir(struct file *file, struct dir_context *ctx)
   309	{
   310		struct ceph_dir_file_info *dfi = file->private_data;
   311		struct inode *inode = file_inode(file);
   312		struct ceph_inode_info *ci = ceph_inode(inode);
   313		struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
   314		struct ceph_mds_client *mdsc = fsc->mdsc;
   315		int i;
   316		int err;
   317		unsigned frag = -1;
   318		struct ceph_mds_reply_info_parsed *rinfo;
   319	
   320		dout("readdir %p file %p pos %llx\n", inode, file, ctx->pos);
   321		if (dfi->file_info.flags & CEPH_F_ATEND)
   322			return 0;
   323	
   324		/* always start with . and .. */
   325		if (ctx->pos == 0) {
   326			dout("readdir off 0 -> '.'\n");
   327			if (!dir_emit(ctx, ".", 1, ceph_present_inode(inode),
   328				    inode->i_mode >> 12))
   329				return 0;
   330			ctx->pos = 1;
   331		}
   332		if (ctx->pos == 1) {
   333			u64 ino;
   334			struct dentry *dentry = file->f_path.dentry;
   335	
   336			spin_lock(&dentry->d_lock);
   337			ino = ceph_present_inode(dentry->d_parent->d_inode);
   338			spin_unlock(&dentry->d_lock);
   339	
   340			dout("readdir off 1 -> '..'\n");
   341			if (!dir_emit(ctx, "..", 2, ino, inode->i_mode >> 12))
   342				return 0;
   343			ctx->pos = 2;
   344		}
   345	
   346		err = fscrypt_prepare_readdir(inode);
   347		if (err)
   348			return err;
   349	
   350		spin_lock(&ci->i_ceph_lock);
   351		/* request Fx cap. if have Fx, we don't need to release Fs cap
   352		 * for later create/unlink. */
   353		__ceph_touch_fmode(ci, mdsc, CEPH_FILE_MODE_WR);
   354		/* can we use the dcache? */
   355		if (ceph_test_mount_opt(fsc, DCACHE) &&
   356		    !ceph_test_mount_opt(fsc, NOASYNCREADDIR) &&
   357		    ceph_snap(inode) != CEPH_SNAPDIR &&
   358		    __ceph_dir_is_complete_ordered(ci) &&
   359		    __ceph_caps_issued_mask_metric(ci, CEPH_CAP_FILE_SHARED, 1)) {
   360			int shared_gen = atomic_read(&ci->i_shared_gen);
   361	
   362			spin_unlock(&ci->i_ceph_lock);
   363			err = __dcache_readdir(file, ctx, shared_gen);
   364			if (err != -EAGAIN)
   365				return err;
   366		} else {
   367			spin_unlock(&ci->i_ceph_lock);
   368		}
   369	
   370		/* proceed with a normal readdir */
   371	more:
   372		/* do we have the correct frag content buffered? */
   373		if (need_send_readdir(dfi, ctx->pos)) {
   374			struct ceph_mds_request *req;
   375			int op = ceph_snap(inode) == CEPH_SNAPDIR ?
   376				CEPH_MDS_OP_LSSNAP : CEPH_MDS_OP_READDIR;
   377	
   378			/* discard old result, if any */
   379			if (dfi->last_readdir) {
   380				ceph_mdsc_put_request(dfi->last_readdir);
   381				dfi->last_readdir = NULL;
   382			}
   383	
   384			if (is_hash_order(ctx->pos)) {
   385				/* fragtree isn't always accurate. choose frag
   386				 * based on previous reply when possible. */
   387				if (frag == (unsigned)-1)
   388					frag = ceph_choose_frag(ci, fpos_hash(ctx->pos),
   389								NULL, NULL);
   390			} else {
   391				frag = fpos_frag(ctx->pos);
   392			}
   393	
   394			dout("readdir fetching %llx.%llx frag %x offset '%s'\n",
   395			     ceph_vinop(inode), frag, dfi->last_name);
   396			req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
   397			if (IS_ERR(req)) {
   398				err = PTR_ERR(req);
   399				goto out;
   400			}
   401			err = ceph_alloc_readdir_reply_buffer(req, inode);
   402			if (err) {
   403				ceph_mdsc_put_request(req);
   404				goto out;
   405			}
   406			/* hints to request -> mds selection code */
   407			req->r_direct_mode = USE_AUTH_MDS;
   408			if (op == CEPH_MDS_OP_READDIR) {
   409				req->r_direct_hash = ceph_frag_value(frag);
   410				__set_bit(CEPH_MDS_R_DIRECT_IS_HASH, &req->r_req_flags);
   411				req->r_inode_drop = CEPH_CAP_FILE_EXCL;
   412			}
   413			if (dfi->last_name) {
   414				struct qstr d_name = { .name = dfi->last_name,
   415						       .len = strlen(dfi->last_name) };
   416	
   417				req->r_path2 = kzalloc(NAME_MAX + 1, GFP_KERNEL);
   418				if (!req->r_path2) {
   419					ceph_mdsc_put_request(req);
   420					err = -ENOMEM;
   421					goto out;
   422				}
   423	
 > 424				err = ceph_encode_encrypted_dname(inode, &d_name, req->r_path2);
   425				if (err < 0) {
   426					ceph_mdsc_put_request(req);
   427					goto out;
   428				}
   429			} else if (is_hash_order(ctx->pos)) {
   430				req->r_args.readdir.offset_hash =
   431					cpu_to_le32(fpos_hash(ctx->pos));
   432			}
   433	
   434			req->r_dir_release_cnt = dfi->dir_release_count;
   435			req->r_dir_ordered_cnt = dfi->dir_ordered_count;
   436			req->r_readdir_cache_idx = dfi->readdir_cache_idx;
   437			req->r_readdir_offset = dfi->next_offset;
   438			req->r_args.readdir.frag = cpu_to_le32(frag);
   439			req->r_args.readdir.flags =
   440					cpu_to_le16(CEPH_READDIR_REPLY_BITFLAGS);
   441	
   442			req->r_inode = inode;
   443			ihold(inode);
   444			req->r_dentry = dget(file->f_path.dentry);
   445			err = ceph_mdsc_do_request(mdsc, NULL, req);
   446			if (err < 0) {
   447				ceph_mdsc_put_request(req);
   448				goto out;
   449			}
   450			dout("readdir got and parsed readdir result=%d on "
   451			     "frag %x, end=%d, complete=%d, hash_order=%d\n",
   452			     err, frag,
   453			     (int)req->r_reply_info.dir_end,
   454			     (int)req->r_reply_info.dir_complete,
   455			     (int)req->r_reply_info.hash_order);
   456	
   457			rinfo = &req->r_reply_info;
   458			if (le32_to_cpu(rinfo->dir_dir->frag) != frag) {
   459				frag = le32_to_cpu(rinfo->dir_dir->frag);
   460				if (!rinfo->hash_order) {
   461					dfi->next_offset = req->r_readdir_offset;
   462					/* adjust ctx->pos to beginning of frag */
   463					ctx->pos = ceph_make_fpos(frag,
   464								  dfi->next_offset,
   465								  false);
   466				}
   467			}
   468	
   469			dfi->frag = frag;
   470			dfi->last_readdir = req;
   471	
   472			if (test_bit(CEPH_MDS_R_DID_PREPOPULATE, &req->r_req_flags)) {
   473				dfi->readdir_cache_idx = req->r_readdir_cache_idx;
   474				if (dfi->readdir_cache_idx < 0) {
   475					/* preclude from marking dir ordered */
   476					dfi->dir_ordered_count = 0;
   477				} else if (ceph_frag_is_leftmost(frag) &&
   478					   dfi->next_offset == 2) {
   479					/* note dir version at start of readdir so
   480					 * we can tell if any dentries get dropped */
   481					dfi->dir_release_count = req->r_dir_release_cnt;
   482					dfi->dir_ordered_count = req->r_dir_ordered_cnt;
   483				}
   484			} else {
   485				dout("readdir !did_prepopulate\n");
   486				/* disable readdir cache */
   487				dfi->readdir_cache_idx = -1;
   488				/* preclude from marking dir complete */
   489				dfi->dir_release_count = 0;
   490			}
   491	
   492			/* note next offset and last dentry name */
   493			if (rinfo->dir_nr > 0) {
   494				struct ceph_mds_reply_dir_entry *rde =
   495						rinfo->dir_entries + (rinfo->dir_nr-1);
   496				unsigned next_offset = req->r_reply_info.dir_end ?
   497						2 : (fpos_off(rde->offset) + 1);
   498				err = note_last_dentry(dfi, rde->name, rde->name_len,
   499						       next_offset);
   500				if (err) {
   501					ceph_mdsc_put_request(dfi->last_readdir);
   502					dfi->last_readdir = NULL;
   503					goto out;
   504				}
   505			} else if (req->r_reply_info.dir_end) {
   506				dfi->next_offset = 2;
   507				/* keep last name */
   508			}
   509		}
   510	
   511		rinfo = &dfi->last_readdir->r_reply_info;
   512		dout("readdir frag %x num %d pos %llx chunk first %llx\n",
   513		     dfi->frag, rinfo->dir_nr, ctx->pos,
   514		     rinfo->dir_nr ? rinfo->dir_entries[0].offset : 0LL);
   515	
   516		i = 0;
   517		/* search start position */
   518		if (rinfo->dir_nr > 0) {
   519			int step, nr = rinfo->dir_nr;
   520			while (nr > 0) {
   521				step = nr >> 1;
   522				if (rinfo->dir_entries[i + step].offset < ctx->pos) {
   523					i +=  step + 1;
   524					nr -= step + 1;
   525				} else {
   526					nr = step;
   527				}
   528			}
   529		}
   530		for (; i < rinfo->dir_nr; i++) {
   531			struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
   532	
   533			BUG_ON(rde->offset < ctx->pos);
   534			BUG_ON(!rde->inode.in);
   535	
   536			ctx->pos = rde->offset;
   537			dout("readdir (%d/%d) -> %llx '%.*s' %p\n",
   538			     i, rinfo->dir_nr, ctx->pos,
   539			     rde->name_len, rde->name, &rde->inode.in);
   540	
   541			if (!dir_emit(ctx, rde->name, rde->name_len,
   542				      ceph_present_ino(inode->i_sb, le64_to_cpu(rde->inode.in->ino)),
   543				      le32_to_cpu(rde->inode.in->mode) >> 12)) {
   544				/*
   545				 * NOTE: Here no need to put the 'dfi->last_readdir',
   546				 * because when dir_emit stops us it's most likely
   547				 * doesn't have enough memory, etc. So for next readdir
   548				 * it will continue.
   549				 */
   550				dout("filldir stopping us...\n");
   551				err = 0;
   552				goto out;
   553			}
   554	
   555			/* Reset the lengths to their original allocated vals */
   556			ctx->pos++;
   557		}
   558	
   559		ceph_mdsc_put_request(dfi->last_readdir);
   560		dfi->last_readdir = NULL;
   561	
   562		if (dfi->next_offset > 2) {
   563			frag = dfi->frag;
   564			goto more;
   565		}
   566	
   567		/* more frags? */
   568		if (!ceph_frag_is_rightmost(dfi->frag)) {
   569			frag = ceph_frag_next(dfi->frag);
   570			if (is_hash_order(ctx->pos)) {
   571				loff_t new_pos = ceph_make_fpos(ceph_frag_value(frag),
   572								dfi->next_offset, true);
   573				if (new_pos > ctx->pos)
   574					ctx->pos = new_pos;
   575				/* keep last_name */
   576			} else {
   577				ctx->pos = ceph_make_fpos(frag, dfi->next_offset,
   578								false);
   579				kfree(dfi->last_name);
   580				dfi->last_name = NULL;
   581			}
   582			dout("readdir next frag is %x\n", frag);
   583			goto more;
   584		}
   585		dfi->file_info.flags |= CEPH_F_ATEND;
   586	
   587		/*
   588		 * if dir_release_count still matches the dir, no dentries
   589		 * were released during the whole readdir, and we should have
   590		 * the complete dir contents in our cache.
   591		 */
   592		if (atomic64_read(&ci->i_release_count) ==
   593						dfi->dir_release_count) {
   594			spin_lock(&ci->i_ceph_lock);
   595			if (dfi->dir_ordered_count ==
   596					atomic64_read(&ci->i_ordered_count)) {
   597				dout(" marking %p complete and ordered\n", inode);
   598				/* use i_size to track number of entries in
   599				 * readdir cache */
   600				BUG_ON(dfi->readdir_cache_idx < 0);
   601				i_size_write(inode, dfi->readdir_cache_idx *
   602					     sizeof(struct dentry*));
   603			} else {
   604				dout(" marking %p complete\n", inode);
   605			}
   606			__ceph_dir_set_complete(ci, dfi->dir_release_count,
   607						dfi->dir_ordered_count);
   608			spin_unlock(&ci->i_ceph_lock);
   609		}
   610		err = 0;
   611		dout("readdir %p file %p done.\n", inode, file);
   612	out:
   613		return err;
   614	}
   615	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
