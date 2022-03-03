Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A00A4CB43A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiCCBP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCCBPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:15:54 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFE42AE17
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646270108; x=1677806108;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=je+ODs4GERna8wQfTQI8BGo+9+tuvKII2QlSAfR+lTE=;
  b=VEtbnA3SuEOvZBZqs01VpJZmZg9h0Y5HnvWCEVdtHL9i7fl7FE1z7h28
   +guLDPWMrV/TchinL+oyjC2zd6zgyd9CnCGVvkAPqbBKYhii8M5bNo++8
   nzw5DTbs8RFmD6298H9llCAPYTMfcNnfTigaETtbeGETBEq3SC0d2BsMs
   Ui0sOVj1O7qpe7fYpSCYqA3xKM9F/uBK2BFDSaw/1yk/4vjLax0gZ0epS
   BQlJcYfhmsYElO28WJtq4FU0sBJtTVtp77OXIzbluWyqC0Vl53AY+WTXm
   j2G+/dLJ0XhPr6x0/3bRbPad0SUlsgnEuM78Tewn2oqmLJAg+ilb4/hXK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233511882"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="233511882"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 17:15:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="535609027"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2022 17:15:06 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPa3d-0002Bv-JD; Thu, 03 Mar 2022 01:15:05 +0000
Date:   Thu, 3 Mar 2022 09:15:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Lawrence <paullawrence@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android-trusty-5.4
 2537/6879] fs/incfs/vfs.c:1307:37: sparse: sparse: non size-preserving
 integer to pointer cast
Message-ID: <202203030947.eI7d79Mg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-trusty-5.4
head:   d556bac5a4d65c759ce3c5a7529aef568f05f650
commit: 383f53ee186a22c3d04cc6809e3b5e13bc2b571d [2537/6879] ANDROID: Incremental fs: Remove unneeded compatibility typedef
config: i386-randconfig-s001-20211124 (https://download.01.org/0day-ci/archive/20220303/202203030947.eI7d79Mg-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/383f53ee186a22c3d04cc6809e3b5e13bc2b571d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-trusty-5.4
        git checkout 383f53ee186a22c3d04cc6809e3b5e13bc2b571d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/incfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/incfs/vfs.c:1307:37: sparse: sparse: non size-preserving integer to pointer cast
   fs/incfs/vfs.c:2054:23: sparse: sparse: cast truncates bits from constant value (5346434e49 becomes 46434e49)

vim +1307 fs/incfs/vfs.c

1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1138  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1139  static long ioctl_create_file(struct mount_info *mi,
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1140  			struct incfs_new_file_args __user *usr_args)
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1141  {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1142  	struct incfs_new_file_args args;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1143  	char *file_id_str = NULL;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1144  	struct dentry *index_file_dentry = NULL;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1145  	struct dentry *named_file_dentry = NULL;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1146  	struct path parent_dir_path = {};
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1147  	struct inode *index_dir_inode = NULL;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1148  	__le64 size_attr_value = 0;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1149  	char *file_name = NULL;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1150  	char *attr_value = NULL;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1151  	int error = 0;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1152  	bool locked = false;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1153  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1154  	if (!mi || !mi->mi_index_dir) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1155  		error = -EFAULT;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1156  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1157  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1158  	if (!access_ok(usr_args, sizeof(args))) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1159  		error = -EFAULT;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1160  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1161  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1162  	if (copy_from_user(&args, usr_args, sizeof(args)) > 0) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1163  		error = -EFAULT;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1164  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1165  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1166  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1167  	file_name = strndup_user(u64_to_user_ptr(args.file_name), PATH_MAX);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1168  	if (IS_ERR(file_name)) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1169  		error = PTR_ERR(file_name);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1170  		file_name = NULL;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1171  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1172  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1173  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1174  	error = validate_name(file_name);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1175  	if (error)
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1176  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1177  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1178  	file_id_str = file_id_to_str(args.file_id);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1179  	if (!file_id_str) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1180  		error = -ENOMEM;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1181  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1182  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1183  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1184  	error = mutex_lock_interruptible(&mi->mi_dir_struct_mutex);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1185  	if (error)
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1186  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1187  	locked = true;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1188  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1189  	/* Find a directory to put the file into. */
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1190  	error = dir_relative_path_resolve(mi,
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1191  			u64_to_user_ptr(args.directory_path),
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1192  			&parent_dir_path);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1193  	if (error)
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1194  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1195  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1196  	if (parent_dir_path.dentry == mi->mi_index_dir) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1197  		/* Can't create a file directly inside .index */
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1198  		error = -EBUSY;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1199  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1200  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1201  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1202  	/* Look up a dentry in the parent dir. It should be negative. */
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1203  	named_file_dentry = incfs_lookup_dentry(parent_dir_path.dentry,
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1204  					file_name);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1205  	if (!named_file_dentry) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1206  		error = -EFAULT;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1207  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1208  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1209  	if (IS_ERR(named_file_dentry)) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1210  		error = PTR_ERR(named_file_dentry);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1211  		named_file_dentry = NULL;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1212  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1213  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1214  	if (d_really_is_positive(named_file_dentry)) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1215  		/* File with this path already exists. */
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1216  		error = -EEXIST;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1217  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1218  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1219  	/* Look up a dentry in the .index dir. It should be negative. */
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1220  	index_file_dentry = incfs_lookup_dentry(mi->mi_index_dir, file_id_str);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1221  	if (!index_file_dentry) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1222  		error = -EFAULT;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1223  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1224  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1225  	if (IS_ERR(index_file_dentry)) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1226  		error = PTR_ERR(index_file_dentry);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1227  		index_file_dentry = NULL;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1228  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1229  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1230  	if (d_really_is_positive(index_file_dentry)) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1231  		/* File with this ID already exists in index. */
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1232  		error = -EEXIST;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1233  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1234  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1235  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1236  	/* Creating a file in the .index dir. */
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1237  	index_dir_inode = d_inode(mi->mi_index_dir);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1238  	inode_lock_nested(index_dir_inode, I_MUTEX_PARENT);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1239  	error = vfs_create(index_dir_inode, index_file_dentry,
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1240  			args.mode, true);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1241  	inode_unlock(index_dir_inode);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1242  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1243  	if (error)
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1244  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1245  	if (!d_really_is_positive(index_file_dentry)) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1246  		error = -EINVAL;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1247  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1248  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1249  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1250  	/* Save the file's ID as an xattr for easy fetching in future. */
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1251  	error = vfs_setxattr(index_file_dentry, INCFS_XATTR_ID_NAME,
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1252  		file_id_str, strlen(file_id_str), XATTR_CREATE);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1253  	if (error) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1254  		pr_debug("incfs: vfs_setxattr err:%d\n", error);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1255  		goto delete_index_file;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1256  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1257  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1258  	/* Save the file's size as an xattr for easy fetching in future. */
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1259  	size_attr_value = cpu_to_le64(args.size);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1260  	error = vfs_setxattr(index_file_dentry, INCFS_XATTR_SIZE_NAME,
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1261  		(char *)&size_attr_value, sizeof(size_attr_value),
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1262  		XATTR_CREATE);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1263  	if (error) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1264  		pr_debug("incfs: vfs_setxattr err:%d\n", error);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1265  		goto delete_index_file;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1266  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1267  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1268  	/* Save the file's attrubute as an xattr */
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1269  	if (args.file_attr_len && args.file_attr) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1270  		if (args.file_attr_len > INCFS_MAX_FILE_ATTR_SIZE) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1271  			error = -E2BIG;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1272  			goto delete_index_file;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1273  		}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1274  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1275  		attr_value = kmalloc(args.file_attr_len, GFP_NOFS);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1276  		if (!attr_value) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1277  			error = -ENOMEM;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1278  			goto delete_index_file;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1279  		}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1280  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1281  		if (!access_ok(u64_to_user_ptr(args.file_attr),
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1282  			       args.file_attr_len)) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1283  			error = -EFAULT;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1284  			goto delete_index_file;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1285  		}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1286  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1287  		if (copy_from_user(attr_value,
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1288  				u64_to_user_ptr(args.file_attr),
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1289  				args.file_attr_len) > 0) {
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1290  			error = -EFAULT;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1291  			goto delete_index_file;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1292  		}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1293  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1294  		error = vfs_setxattr(index_file_dentry,
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1295  				INCFS_XATTR_METADATA_NAME,
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1296  				attr_value, args.file_attr_len,
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1297  				XATTR_CREATE);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1298  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1299  		if (error)
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1300  			goto delete_index_file;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1301  	}
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1302  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1303  	/* Initializing a newly created file. */
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1304  	error = init_new_file(mi, index_file_dentry, &args.file_id, args.size,
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1305  			range(attr_value, args.file_attr_len),
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1306  			(struct incfs_file_signature_info __user *)
1be052b20ba04b6 Eugene Zemtsov 2019-11-18 @1307  				args.signature_info);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1308  	if (error)
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1309  		goto delete_index_file;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1310  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1311  	/* Linking a file with it's real name from the requested dir. */
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1312  	error = incfs_link(index_file_dentry, named_file_dentry);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1313  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1314  	if (!error)
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1315  		goto out;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1316  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1317  delete_index_file:
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1318  	incfs_unlink(index_file_dentry);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1319  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1320  out:
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1321  	if (error)
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1322  		pr_debug("incfs: %s err:%d\n", __func__, error);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1323  
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1324  	kfree(file_id_str);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1325  	kfree(file_name);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1326  	kfree(attr_value);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1327  	dput(named_file_dentry);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1328  	dput(index_file_dentry);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1329  	path_put(&parent_dir_path);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1330  	if (locked)
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1331  		mutex_unlock(&mi->mi_dir_struct_mutex);
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1332  	return error;
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1333  }
1be052b20ba04b6 Eugene Zemtsov 2019-11-18  1334  

:::::: The code at line 1307 was first introduced by commit
:::::: 1be052b20ba04b635cf87bcff80de5314697953e ANDROID: Initial commit of Incremental FS

:::::: TO: Eugene Zemtsov <ezemtsov@google.com>
:::::: CC: Paul Lawrence <paullawrence@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
