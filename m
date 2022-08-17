Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82451596DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiHQLiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiHQLio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:38:44 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B749F74E20
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=HJQ6h2CK8nzKj4f9G+WkglC05CCb+QFH1WGJ/jp9tTU=;
  b=hn8S9wYW2yA/7JvArqu5dx53f+ccxN0wIH+s3wMnfNqjuRucJY6aWHe1
   U5t/7T4eMPT39pEo3/gtybEYVqEXGUf08FeU9qsth06jk0Px/DVC5bZP3
   DgO2gp4OBTOOYsRWTfhUClHuVUG/VC+K2jXgKodQVQiRxTSj0R+K5SbF6
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.93,243,1654552800"; 
   d="scan'208";a="49010173"
Received: from unknown (HELO hadrien) ([95.166.247.26])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 13:38:39 +0200
Date:   Wed, 17 Aug 2022 13:38:38 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev.2022.08.03b 68/79]
 kernel/rcu/rcutorture.c:1194:18-31: duplicated argument to && or || (fwd)
Message-ID: <alpine.DEB.2.22.394.2208171337360.2482@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

!gp_cond_exp1 appears twice on line 1194.

julia

---------- Forwarded message ----------
Date: Sat, 13 Aug 2022 13:44:24 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev.2022.08.03b 68/79]
    kernel/rcu/rcutorture.c:1194:18-31: duplicated argument to && or ||

BCC: lkp@intel.com
CC: kbuild-all@lists.01.org
CC: Ammar Faizi <ammarfaizi2@gnuweeb.org>
CC: "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>
CC: linux-kernel@vger.kernel.org
TO: "Paul E. McKenney" <paulmck@kernel.org>

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev.2022.08.03b
head:   ce1b7858edab35808512996e67c82cac4273381c
commit: 12a0809f363631e425b29958f37327ae09a44d06 [68/79] rcu: Add full-sized polling for cond_sync_full()
:::::: branch date: 8 days ago
:::::: commit date: 8 days ago
config: xtensa-randconfig-c032-20220811 (https://download.01.org/0day-ci/archive/20220813/202208131334.n1nRXiCK-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

cocci warnings: (new ones prefixed by >>)
>> kernel/rcu/rcutorture.c:1194:18-31: duplicated argument to && or ||

vim +1194 kernel/rcu/rcutorture.c

18fbf307b7319a kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-16  1182
a241ec65aeac3d kernel/rcutorture.c     Paul E. McKenney 2005-10-30  1183  /*
18fbf307b7319a kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-16  1184   * Determine which grace-period primitives are available.
a241ec65aeac3d kernel/rcutorture.c     Paul E. McKenney 2005-10-30  1185   */
18fbf307b7319a kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-16  1186  static void rcu_torture_write_types(void)
a241ec65aeac3d kernel/rcutorture.c     Paul E. McKenney 2005-10-30  1187  {
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04  1188  	bool gp_cond1 = gp_cond, gp_cond_exp1 = gp_cond_exp, gp_cond_full1 = gp_cond_full;
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04  1189  	bool gp_exp1 = gp_exp, gp_poll_exp1 = gp_poll_exp, gp_poll_exp_full1 = gp_poll_exp_full;
582a3d589d761b kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-03  1190  	bool gp_normal1 = gp_normal, gp_poll1 = gp_poll, gp_poll_full1 = gp_poll_full;
582a3d589d761b kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-03  1191  	bool gp_sync1 = gp_sync;
dbdf65b1b7f8ec kernel/rcutorture.c     Ingo Molnar      2005-11-13  1192
a48f3fad4f97fe kernel/rcu/rcutorture.c Paul E. McKenney 2014-03-18  1193  	/* Initialize synctype[] array.  If none set, take default. */
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04 @1194  	if (!gp_cond1 && !gp_cond_exp1 && !gp_cond_exp1 && !gp_exp1 && !gp_poll_exp &&
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04  1195  	    !gp_poll_exp_full && !gp_normal1 && !gp_poll1 && !gp_poll_full1 && !gp_sync1)
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04  1196  		gp_cond1 = gp_cond_exp1 = gp_cond_full1 = gp_exp1 = gp_poll_exp1 =
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04  1197  			   gp_poll_exp_full1 = gp_normal1 = gp_poll1 = gp_poll_full1 =
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04  1198  			   gp_sync1 = true;
fd56f64b4e3b9c kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-13  1199  	if (gp_cond1 && cur_ops->get_gp_state && cur_ops->cond_sync) {
a48f3fad4f97fe kernel/rcu/rcutorture.c Paul E. McKenney 2014-03-18  1200  		synctype[nsynctypes++] = RTWS_COND_GET;
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1201  		pr_info("%s: Testing conditional GPs.\n", __func__);
fd56f64b4e3b9c kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-13  1202  	} else if (gp_cond && (!cur_ops->get_gp_state || !cur_ops->cond_sync)) {
e0d31a34c6db63 kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-01  1203  		pr_alert("%s: gp_cond without primitives.\n", __func__);
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1204  	}
11d62f0f43a35d kernel/rcu/rcutorture.c Paul E. McKenney 2022-02-01  1205  	if (gp_cond_exp1 && cur_ops->get_gp_state_exp && cur_ops->cond_sync_exp) {
11d62f0f43a35d kernel/rcu/rcutorture.c Paul E. McKenney 2022-02-01  1206  		synctype[nsynctypes++] = RTWS_COND_GET_EXP;
11d62f0f43a35d kernel/rcu/rcutorture.c Paul E. McKenney 2022-02-01  1207  		pr_info("%s: Testing conditional expedited GPs.\n", __func__);
11d62f0f43a35d kernel/rcu/rcutorture.c Paul E. McKenney 2022-02-01  1208  	} else if (gp_cond_exp && (!cur_ops->get_gp_state_exp || !cur_ops->cond_sync_exp)) {
11d62f0f43a35d kernel/rcu/rcutorture.c Paul E. McKenney 2022-02-01  1209  		pr_alert("%s: gp_cond_exp without primitives.\n", __func__);
11d62f0f43a35d kernel/rcu/rcutorture.c Paul E. McKenney 2022-02-01  1210  	}
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04  1211  	if (gp_cond_full1 && cur_ops->get_gp_state && cur_ops->cond_sync_full) {
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04  1212  		synctype[nsynctypes++] = RTWS_COND_GET_FULL;
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04  1213  		pr_info("%s: Testing conditional full-state GPs.\n", __func__);
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04  1214  	} else if (gp_cond_full && (!cur_ops->get_gp_state || !cur_ops->cond_sync_full)) {
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04  1215  		pr_alert("%s: gp_cond_full without primitives.\n", __func__);
12a0809f363631 kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-04  1216  	}
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1217  	if (gp_exp1 && cur_ops->exp_sync) {
a48f3fad4f97fe kernel/rcu/rcutorture.c Paul E. McKenney 2014-03-18  1218  		synctype[nsynctypes++] = RTWS_EXP_SYNC;
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1219  		pr_info("%s: Testing expedited GPs.\n", __func__);
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1220  	} else if (gp_exp && !cur_ops->exp_sync) {
e0d31a34c6db63 kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-01  1221  		pr_alert("%s: gp_exp without primitives.\n", __func__);
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1222  	}
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1223  	if (gp_normal1 && cur_ops->deferred_free) {
a48f3fad4f97fe kernel/rcu/rcutorture.c Paul E. McKenney 2014-03-18  1224  		synctype[nsynctypes++] = RTWS_DEF_FREE;
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1225  		pr_info("%s: Testing asynchronous GPs.\n", __func__);
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1226  	} else if (gp_normal && !cur_ops->deferred_free) {
e0d31a34c6db63 kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-01  1227  		pr_alert("%s: gp_normal without primitives.\n", __func__);
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1228  	}
0fd0548db13346 kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-13  1229  	if (gp_poll1 && cur_ops->start_gp_poll && cur_ops->poll_gp_state) {
0fd0548db13346 kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-13  1230  		synctype[nsynctypes++] = RTWS_POLL_GET;
0fd0548db13346 kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-13  1231  		pr_info("%s: Testing polling GPs.\n", __func__);
0fd0548db13346 kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-13  1232  	} else if (gp_poll && (!cur_ops->start_gp_poll || !cur_ops->poll_gp_state)) {
0fd0548db13346 kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-13  1233  		pr_alert("%s: gp_poll without primitives.\n", __func__);
0fd0548db13346 kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-13  1234  	}
1e5cbdf2877d3f kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-02  1235  	if (gp_poll_full1 && cur_ops->start_gp_poll_full && cur_ops->poll_gp_state_full) {
1e5cbdf2877d3f kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-02  1236  		synctype[nsynctypes++] = RTWS_POLL_GET_FULL;
1e5cbdf2877d3f kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-02  1237  		pr_info("%s: Testing polling full-state GPs.\n", __func__);
1e5cbdf2877d3f kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-02  1238  	} else if (gp_poll_full && (!cur_ops->start_gp_poll_full || !cur_ops->poll_gp_state_full)) {
1e5cbdf2877d3f kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-02  1239  		pr_alert("%s: gp_poll_full without primitives.\n", __func__);
1e5cbdf2877d3f kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-02  1240  	}
11d62f0f43a35d kernel/rcu/rcutorture.c Paul E. McKenney 2022-02-01  1241  	if (gp_poll_exp1 && cur_ops->start_gp_poll_exp && cur_ops->poll_gp_state_exp) {
11d62f0f43a35d kernel/rcu/rcutorture.c Paul E. McKenney 2022-02-01  1242  		synctype[nsynctypes++] = RTWS_POLL_GET_EXP;
11d62f0f43a35d kernel/rcu/rcutorture.c Paul E. McKenney 2022-02-01  1243  		pr_info("%s: Testing polling expedited GPs.\n", __func__);
11d62f0f43a35d kernel/rcu/rcutorture.c Paul E. McKenney 2022-02-01  1244  	} else if (gp_poll_exp && (!cur_ops->start_gp_poll_exp || !cur_ops->poll_gp_state_exp)) {
11d62f0f43a35d kernel/rcu/rcutorture.c Paul E. McKenney 2022-02-01  1245  		pr_alert("%s: gp_poll_exp without primitives.\n", __func__);
11d62f0f43a35d kernel/rcu/rcutorture.c Paul E. McKenney 2022-02-01  1246  	}
582a3d589d761b kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-03  1247  	if (gp_poll_exp_full1 && cur_ops->start_gp_poll_exp_full && cur_ops->poll_gp_state_full) {
582a3d589d761b kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-03  1248  		synctype[nsynctypes++] = RTWS_POLL_GET_EXP_FULL;
582a3d589d761b kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-03  1249  		pr_info("%s: Testing polling full-state expedited GPs.\n", __func__);
582a3d589d761b kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-03  1250  	} else if (gp_poll_exp_full &&
582a3d589d761b kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-03  1251  		   (!cur_ops->start_gp_poll_exp_full || !cur_ops->poll_gp_state_full)) {
582a3d589d761b kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-03  1252  		pr_alert("%s: gp_poll_exp_full without primitives.\n", __func__);
582a3d589d761b kernel/rcu/rcutorture.c Paul E. McKenney 2022-08-03  1253  	}
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1254  	if (gp_sync1 && cur_ops->sync) {
f0bf8fab4f311c kernel/rcu/rcutorture.c Paul E. McKenney 2014-03-21  1255  		synctype[nsynctypes++] = RTWS_SYNC;
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1256  		pr_info("%s: Testing normal GPs.\n", __func__);
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1257  	} else if (gp_sync && !cur_ops->sync) {
e0d31a34c6db63 kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-01  1258  		pr_alert("%s: gp_sync without primitives.\n", __func__);
db0c1a8aba31ed kernel/rcu/rcutorture.c Paul E. McKenney 2017-12-08  1259  	}
18fbf307b7319a kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-16  1260  }
18fbf307b7319a kernel/rcu/rcutorture.c Paul E. McKenney 2020-11-16  1261

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
