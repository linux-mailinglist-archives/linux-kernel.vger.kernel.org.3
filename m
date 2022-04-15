Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C365502171
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 06:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349430AbiDOEl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 00:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiDOElw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:41:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16FCE85
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649997564; x=1681533564;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v9kaEdVmVj3SEe2NwZ7JD3ExQOw4zpnwuAKTUt2Ln78=;
  b=XIeZTUmtdvHKtyHvG69KISRbiRl3HJv5fmjJdZpBv4gft1m5FM4bDSQh
   v0UjaTf7fnXibNetrrpadBV0AOnxIRC8owl2fnZE1xMwoEbBfH7q1jTt9
   z+AR7uGajzrpfj2TA2+z8T3rnhga+AUfyFtULNbyiKWgQBPUZUPuiXqYc
   Af+3TW1/Yu534l3LeBndTRhq3yH8PcO+PuuWeKEBKnRsbBfFE47IHlc2Y
   Ni+/rpNJxOyQFZPOS4+pEQHDz9ecipxAa6tdx7JHnL8fh0/8kRYwzToqu
   l5R3UUqVtIK6Z28nxMZIIQ5WP4GJ2uMYRBYrIj5IzrwzAHZIYIt6rffjW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349528216"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="349528216"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 21:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="591440702"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2022 21:39:22 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfDju-0001WP-7B;
        Fri, 15 Apr 2022 04:39:22 +0000
Date:   Fri, 15 Apr 2022 12:38:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 283/396]
 fs/xfs/libxfs/xfs_bmap.c:5297:17: warning: Local variable 'flags' shadows
 outer variable [shadowVariable]
Message-ID: <202204151228.UVfogpPF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   bd756ef7af68274b79308166ee64949d288be861
commit: 1f5b7812f0d7f8d634b30fa8d286ef85084165fb [283/396] xfs: convert "skip_discard" to a proper flags bitset
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 1f5b7812f0d7f8d634b30fa8d286ef85084165fb
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> fs/xfs/libxfs/xfs_bmap.c:5297:17: warning: Local variable 'flags' shadows outer variable [shadowVariable]
      unsigned int flags = 0;
                   ^
   fs/xfs/libxfs/xfs_bmap.c:5066:8: note: Shadowed declaration
    int   flags = 0;/* inode logging flags */
          ^
   fs/xfs/libxfs/xfs_bmap.c:5297:17: note: Shadow variable
      unsigned int flags = 0;
                   ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> fs/xfs/xfs_itable.c:79:8: warning: Redundant initialization for 'error'. The initialized value is overwritten before it is read. [redundantInitialization]
    error = xfs_iget(mp, tp, ino,
          ^
   fs/xfs/xfs_itable.c:77:14: note: error is initialized
    int   error = -EINVAL;
                ^
   fs/xfs/xfs_itable.c:79:8: note: error is overwritten
    error = xfs_iget(mp, tp, ino,
          ^
   fs/xfs/libxfs/xfs_bmap.c:3445:6: warning: The if condition is the same as the previous if condition [duplicateCondition]
    if (align) {
        ^
   fs/xfs/libxfs/xfs_bmap.c:3436:6: note: First condition
    if (align) {
        ^
   fs/xfs/libxfs/xfs_bmap.c:3445:6: note: Second condition
    if (align) {
        ^
   fs/xfs/libxfs/xfs_bmap.c:113:24: warning: Parameter 'irec' can be declared with const [constParameter]
    struct xfs_bmbt_irec *irec,
                          ^
   fs/xfs/libxfs/xfs_bmap.c:3268:17: warning: Parameter 'blen' can be declared with const [constParameter]
    xfs_extlen_t  *blen,
                   ^

vim +/flags +5297 fs/xfs/libxfs/xfs_bmap.c

  5046	
  5047	/*
  5048	 * Called by xfs_bmapi to update file extent records and the btree
  5049	 * after removing space.
  5050	 */
  5051	STATIC int				/* error */
  5052	xfs_bmap_del_extent_real(
  5053		xfs_inode_t		*ip,	/* incore inode pointer */
  5054		xfs_trans_t		*tp,	/* current transaction pointer */
  5055		struct xfs_iext_cursor	*icur,
  5056		struct xfs_btree_cur	*cur,	/* if null, not a btree */
  5057		xfs_bmbt_irec_t		*del,	/* data to remove from extents */
  5058		int			*logflagsp, /* inode logging flags */
  5059		int			whichfork, /* data or attr fork */
  5060		int			bflags)	/* bmapi flags */
  5061	{
  5062		xfs_fsblock_t		del_endblock=0;	/* first block past del */
  5063		xfs_fileoff_t		del_endoff;	/* first offset past del */
  5064		int			do_fx;	/* free extent at end of routine */
  5065		int			error;	/* error return value */
  5066		int			flags = 0;/* inode logging flags */
  5067		struct xfs_bmbt_irec	got;	/* current extent entry */
  5068		xfs_fileoff_t		got_endoff;	/* first offset past got */
  5069		int			i;	/* temp state */
  5070		struct xfs_ifork	*ifp;	/* inode fork pointer */
  5071		xfs_mount_t		*mp;	/* mount structure */
  5072		xfs_filblks_t		nblks;	/* quota/sb block count */
  5073		xfs_bmbt_irec_t		new;	/* new record to be inserted */
  5074		/* REFERENCED */
  5075		uint			qfield;	/* quota field to update */
  5076		int			state = xfs_bmap_fork_to_state(whichfork);
  5077		struct xfs_bmbt_irec	old;
  5078	
  5079		mp = ip->i_mount;
  5080		XFS_STATS_INC(mp, xs_del_exlist);
  5081	
  5082		ifp = XFS_IFORK_PTR(ip, whichfork);
  5083		ASSERT(del->br_blockcount > 0);
  5084		xfs_iext_get_extent(ifp, icur, &got);
  5085		ASSERT(got.br_startoff <= del->br_startoff);
  5086		del_endoff = del->br_startoff + del->br_blockcount;
  5087		got_endoff = got.br_startoff + got.br_blockcount;
  5088		ASSERT(got_endoff >= del_endoff);
  5089		ASSERT(!isnullstartblock(got.br_startblock));
  5090		qfield = 0;
  5091		error = 0;
  5092	
  5093		/*
  5094		 * If it's the case where the directory code is running with no block
  5095		 * reservation, and the deleted block is in the middle of its extent,
  5096		 * and the resulting insert of an extent would cause transformation to
  5097		 * btree format, then reject it.  The calling code will then swap blocks
  5098		 * around instead.  We have to do this now, rather than waiting for the
  5099		 * conversion to btree format, since the transaction will be dirty then.
  5100		 */
  5101		if (tp->t_blk_res == 0 &&
  5102		    ifp->if_format == XFS_DINODE_FMT_EXTENTS &&
  5103		    ifp->if_nextents >= XFS_IFORK_MAXEXT(ip, whichfork) &&
  5104		    del->br_startoff > got.br_startoff && del_endoff < got_endoff)
  5105			return -ENOSPC;
  5106	
  5107		flags = XFS_ILOG_CORE;
  5108		if (xfs_ifork_is_realtime(ip, whichfork)) {
  5109			if (!(bflags & XFS_BMAPI_REMAP)) {
  5110				error = xfs_rtfree_blocks(tp, del->br_startblock,
  5111						del->br_blockcount);
  5112				if (error)
  5113					goto done;
  5114			}
  5115			do_fx = 0;
  5116			qfield = XFS_TRANS_DQ_RTBCOUNT;
  5117		} else {
  5118			do_fx = 1;
  5119			qfield = XFS_TRANS_DQ_BCOUNT;
  5120		}
  5121		nblks = del->br_blockcount;
  5122	
  5123		del_endblock = del->br_startblock + del->br_blockcount;
  5124		if (cur) {
  5125			error = xfs_bmbt_lookup_eq(cur, &got, &i);
  5126			if (error)
  5127				goto done;
  5128			if (XFS_IS_CORRUPT(mp, i != 1)) {
  5129				xfs_btree_mark_sick(cur);
  5130				error = -EFSCORRUPTED;
  5131				goto done;
  5132			}
  5133		}
  5134	
  5135		if (got.br_startoff == del->br_startoff)
  5136			state |= BMAP_LEFT_FILLING;
  5137		if (got_endoff == del_endoff)
  5138			state |= BMAP_RIGHT_FILLING;
  5139	
  5140		switch (state & (BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING)) {
  5141		case BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING:
  5142			/*
  5143			 * Matches the whole extent.  Delete the entry.
  5144			 */
  5145			xfs_iext_remove(ip, icur, state);
  5146			xfs_iext_prev(ifp, icur);
  5147			ifp->if_nextents--;
  5148	
  5149			flags |= XFS_ILOG_CORE;
  5150			if (!cur) {
  5151				flags |= xfs_ilog_fext(whichfork);
  5152				break;
  5153			}
  5154			if ((error = xfs_btree_delete(cur, &i)))
  5155				goto done;
  5156			if (XFS_IS_CORRUPT(mp, i != 1)) {
  5157				xfs_btree_mark_sick(cur);
  5158				error = -EFSCORRUPTED;
  5159				goto done;
  5160			}
  5161			break;
  5162		case BMAP_LEFT_FILLING:
  5163			/*
  5164			 * Deleting the first part of the extent.
  5165			 */
  5166			got.br_startoff = del_endoff;
  5167			got.br_startblock = del_endblock;
  5168			got.br_blockcount -= del->br_blockcount;
  5169			xfs_iext_update_extent(ip, state, icur, &got);
  5170			if (!cur) {
  5171				flags |= xfs_ilog_fext(whichfork);
  5172				break;
  5173			}
  5174			error = xfs_bmbt_update(cur, &got);
  5175			if (error)
  5176				goto done;
  5177			break;
  5178		case BMAP_RIGHT_FILLING:
  5179			/*
  5180			 * Deleting the last part of the extent.
  5181			 */
  5182			got.br_blockcount -= del->br_blockcount;
  5183			xfs_iext_update_extent(ip, state, icur, &got);
  5184			if (!cur) {
  5185				flags |= xfs_ilog_fext(whichfork);
  5186				break;
  5187			}
  5188			error = xfs_bmbt_update(cur, &got);
  5189			if (error)
  5190				goto done;
  5191			break;
  5192		case 0:
  5193			/*
  5194			 * Deleting the middle of the extent.
  5195			 */
  5196	
  5197			/*
  5198			 * For directories, -ENOSPC is returned since a directory entry
  5199			 * remove operation must not fail due to low extent count
  5200			 * availability. -ENOSPC will be handled by higher layers of XFS
  5201			 * by letting the corresponding empty Data/Free blocks to linger
  5202			 * until a future remove operation. Dabtree blocks would be
  5203			 * swapped with the last block in the leaf space and then the
  5204			 * new last block will be unmapped.
  5205			 *
  5206			 * The above logic also applies to the source directory entry of
  5207			 * a rename operation.
  5208			 */
  5209			error = xfs_iext_count_may_overflow(ip, whichfork, 1);
  5210			if (error) {
  5211				ASSERT(S_ISDIR(VFS_I(ip)->i_mode) &&
  5212					whichfork == XFS_DATA_FORK);
  5213				error = -ENOSPC;
  5214				goto done;
  5215			}
  5216	
  5217			old = got;
  5218	
  5219			got.br_blockcount = del->br_startoff - got.br_startoff;
  5220			xfs_iext_update_extent(ip, state, icur, &got);
  5221	
  5222			new.br_startoff = del_endoff;
  5223			new.br_blockcount = got_endoff - del_endoff;
  5224			new.br_state = got.br_state;
  5225			new.br_startblock = del_endblock;
  5226	
  5227			flags |= XFS_ILOG_CORE;
  5228			if (cur) {
  5229				error = xfs_bmbt_update(cur, &got);
  5230				if (error)
  5231					goto done;
  5232				error = xfs_btree_increment(cur, 0, &i);
  5233				if (error)
  5234					goto done;
  5235				cur->bc_rec.b = new;
  5236				error = xfs_btree_insert(cur, &i);
  5237				if (error && error != -ENOSPC)
  5238					goto done;
  5239				/*
  5240				 * If get no-space back from btree insert, it tried a
  5241				 * split, and we have a zero block reservation.  Fix up
  5242				 * our state and return the error.
  5243				 */
  5244				if (error == -ENOSPC) {
  5245					/*
  5246					 * Reset the cursor, don't trust it after any
  5247					 * insert operation.
  5248					 */
  5249					error = xfs_bmbt_lookup_eq(cur, &got, &i);
  5250					if (error)
  5251						goto done;
  5252					if (XFS_IS_CORRUPT(mp, i != 1)) {
  5253						xfs_btree_mark_sick(cur);
  5254						error = -EFSCORRUPTED;
  5255						goto done;
  5256					}
  5257					/*
  5258					 * Update the btree record back
  5259					 * to the original value.
  5260					 */
  5261					error = xfs_bmbt_update(cur, &old);
  5262					if (error)
  5263						goto done;
  5264					/*
  5265					 * Reset the extent record back
  5266					 * to the original value.
  5267					 */
  5268					xfs_iext_update_extent(ip, state, icur, &old);
  5269					flags = 0;
  5270					error = -ENOSPC;
  5271					goto done;
  5272				}
  5273				if (XFS_IS_CORRUPT(mp, i != 1)) {
  5274					xfs_btree_mark_sick(cur);
  5275					error = -EFSCORRUPTED;
  5276					goto done;
  5277				}
  5278			} else
  5279				flags |= xfs_ilog_fext(whichfork);
  5280	
  5281			ifp->if_nextents++;
  5282			xfs_iext_next(ifp, icur);
  5283			xfs_iext_insert(ip, icur, &new, state);
  5284			break;
  5285		}
  5286	
  5287		/* remove reverse mapping */
  5288		xfs_rmap_unmap_extent(tp, ip, whichfork, del);
  5289	
  5290		/*
  5291		 * If we need to, add to list of extents to delete.
  5292		 */
  5293		if (do_fx && !(bflags & XFS_BMAPI_REMAP)) {
  5294			if (xfs_is_reflink_inode(ip) && whichfork == XFS_DATA_FORK) {
  5295				xfs_refcount_decrease_extent(tp, del);
  5296			} else {
> 5297				unsigned int	flags = 0;
  5298	
  5299				if ((bflags & XFS_BMAPI_NODISCARD) ||
  5300				    del->br_state == XFS_EXT_UNWRITTEN)
  5301					flags |= XFS_FREE_EXTENT_SKIP_DISCARD;
  5302	
  5303				xfs_free_extent_later(tp, del->br_startblock,
  5304						del->br_blockcount, NULL, flags);
  5305			}
  5306		}
  5307	
  5308		/*
  5309		 * Adjust inode # blocks in the file.
  5310		 */
  5311		if (nblks)
  5312			ip->i_nblocks -= nblks;
  5313		/*
  5314		 * Adjust quota data.
  5315		 */
  5316		if (qfield && !(bflags & XFS_BMAPI_REMAP))
  5317			xfs_trans_mod_dquot_byino(tp, ip, qfield, (long)-nblks);
  5318	
  5319	done:
  5320		*logflagsp = flags;
  5321		return error;
  5322	}
  5323	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
