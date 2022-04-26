Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06B650FF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351174AbiDZNyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351147AbiDZNyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:54:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9986E8D4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650981066; x=1682517066;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1V0/3lCFUFvYH380s9fH3oZRP3EJgrr3lCquxLUB5Gk=;
  b=Ebu1hRDzfCo5ziMPg73shOezXYw1Qr2q3kYwUtgZPCcYYKhk6hUS8B/U
   UrUCVHRFJWkhQyGAfeBA4DPXpIU/7qpWNtLhuEmnZ/1Ztw3VXa69/xmNZ
   srszgZV7//mzwHL400OZPP39f13lkbeH6jydluE8FEo4YS53dBRaoV5vy
   +X5fFTy8VSTRLYyrZVA0fNU053M+9IqREpcJTCaytI1Q03pJAn2yk6gd2
   SfxhDYsYv3nagPzpvjx9fup6oiKi1YEQJKa3gHseohv9TrHiw7UlfJR5k
   utUw605pPSENJK9cqk+RM9EcW2k4wpbPdEE8z9w3icFTgfUSAJz4CpviR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264426966"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="264426966"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 06:51:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="558317960"
Received: from liuyujie-mobl.ccr.corp.intel.com ([10.249.168.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 06:51:02 -0700
From:   Yujie Liu <yujie.liu@intel.com>
To:     Philip Li <philip.li@intel.com>
Cc:     lkp-devops@eclists.intel.com, Yujie Liu <yujie.liu@intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH lkp-cloud] spec/kbuild_bisect_queue: update kismet error id format and reproduce command
Date:   Tue, 26 Apr 2022 21:51:00 +0800
Message-Id: <20220426135100.2831-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$ rake spec-slow spec=3Dkbuild_bisect_kismet debug=3D1 code=3D1 C_ROOT=3D/h=
ome/jenkins/rake-spec-test/kernel-tests
start spec

/usr/bin/ruby2.5 -I/var/lib/gems/2.5.0/gems/rspec-support-3.11.0/lib:/var/l=
ib/gems/2.5.0/gems/rspec-core-3.11.0/lib /var/lib/gems/2.5.0/gems/rspec-cor=
e-3.11.0/exe/rspec --pattern spec/\*\*\{,/\*/\*\*\}/kbuild_bisect_kismet_sp=
ec.rb --tag speed:slow
Run options: include {:speed=3D>"slow"}
/tmp/qa-20220426-21054-w5d450
latest: Pulling from kbuild
Digest: sha256:c1bc7056e6b210b81791496bf7987b64edfd12b4d300252edda8f54446c5=
7334
Status: Image is up to date for lkp-server:5000/kbuild:latest
lkp-server:5000/kbuild:latest
.

Finished in 57 minutes 34 seconds (files took 1.12 seconds to load)
1 example, 0 failures

the final content of report mail is:

CC: kbuild-all@lists.01.org
BCC: lkp@intel.com
CC: linux-kernel@vger.kernel.org
TO: Artur Rojek <contact@artur-rojek.eu>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   d615b5416f8a1afeb82d13b238f8152c572d59c0
commit: 2c2b364fddd551f0da98953618e264c098dfa140 Input: joystick - add ADC =
attached joystick driver.
date:   1 year, 7 months ago
:::::: branch date: 18 hours ago
:::::: commit date: 1 year, 7 months ago
reproduce:
  download attached .config.gz and extract .config to linux source tree
  run "make ARCH=3Dx86_64 olddefconfig"

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> WARNING: unmet direct dependencies detected, selectee: CONFIG_IIO_BUFFER=
_CB, selector: CONFIG_JOYSTICK_ADC

   WARNING: unmet direct dependencies detected for IIO_BUFFER_CB
     Depends on [n]: IIO [=3Dy] && IIO_BUFFER [=3Dn]
     Selected by [y]:
     - JOYSTICK_ADC [=3Dy] && !UML && INPUT [=3Dy] && INPUT_JOYSTICK [=3Dy]=
 && IIO [=3Dy]

--
0-DAY CI Kernel Test Service
https://01.org/lkp

--RWj8+mpoThLpL0oB
Content-Type: application/gzip
Content-Disposition: attachment; filename=3D".config.gz"
Content-Transfer-Encoding: base64
...

Link: https://jira.devtools.intel.com/browse/ZDAYCI-15410
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 ...d-selectee:CONFIG_IIO_BUFFER_CB-selector:CONFIG_JOYSTICK_ADC | 1 +
 ...-udd-x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-.config | 1 -
 spec/kbuild_bisect_queue/kbuild_bisect_kismet_spec.rb           | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 create mode 100644 spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fdd=
d551f0da98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/WAR=
NING:unmet-direct-dependencies-detected-selectee:CONFIG_IIO_BUFFER_CB-selec=
tor:CONFIG_JOYSTICK_ADC
 delete mode 100644 spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fdd=
d551f0da98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/x86=
_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-UNMET_ALARM-True-kismet-test-c=
ases-udd-x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-.config

diff --git a/spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd551f0d=
a98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/WARNING:un=
met-direct-dependencies-detected-selectee:CONFIG_IIO_BUFFER_CB-selector:CON=
FIG_JOYSTICK_ADC b/spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd=
551f0da98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/WARN=
ING:unmet-direct-dependencies-detected-selectee:CONFIG_IIO_BUFFER_CB-select=
or:CONFIG_JOYSTICK_ADC
new file mode 100644
index 0000000..64e3ea7
--- /dev/null
+++ b/spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd551f0da989536=
18e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/WARNING:unmet-dir=
ect-dependencies-detected-selectee:CONFIG_IIO_BUFFER_CB-selector:CONFIG_JOY=
STICK_ADC
@@ -0,0 +1 @@
+WARNING: unmet direct dependencies detected, selectee: CONFIG_IIO_BUFFER_C=
B, selector: CONFIG_JOYSTICK_ADC
diff --git a/spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd551f0d=
a98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/x86_64-CON=
FIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-UNMET_ALARM-True-kismet-test-cases-ud=
d-x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-.config b/spec/kbuild_bis=
ect_queue/kbuild/bisect-queue/2c2b364fddd551f0da98953618e264c098dfa140:gcc-=
11:x86_64-allnoconfig/.reduce_errors/x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOY=
STICK_ADC-UNMET_ALARM-True-kismet-test-cases-udd-x86_64-CONFIG_IIO_BUFFER_C=
B-CONFIG_JOYSTICK_ADC-.config
deleted file mode 100644
index ec7df3e..0000000
--- a/spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd551f0da989536=
18e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/x86_64-CONFIG_IIO=
_BUFFER_CB-CONFIG_JOYSTICK_ADC-UNMET_ALARM-True-kismet-test-cases-udd-x86_6=
4-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-.config
+++ /dev/null
@@ -1 +0,0 @@
-x86_64,CONFIG_IIO_BUFFER_CB,CONFIG_JOYSTICK_ADC,0,0,UNMET_ALARM,True,kisme=
t-test-cases/udd-x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-0-0.config=
=0D
diff --git a/spec/kbuild_bisect_queue/kbuild_bisect_kismet_spec.rb b/spec/k=
build_bisect_queue/kbuild_bisect_kismet_spec.rb
index 000233b..736bfc6 100644
--- a/spec/kbuild_bisect_queue/kbuild_bisect_kismet_spec.rb
+++ b/spec/kbuild_bisect_queue/kbuild_bisect_kismet_spec.rb
@@ -7,7 +7,7 @@ describe 'kbuild_worker', speed: 'slow' do
                     commit: '2c2b364fddd551f0da98953618e264c098dfa140',
                     first_bad_branch: 'linus/master',
                     first_bad_commit: '2c2b364fddd551f0da98953618e264c098d=
fa140',
-                    reproduce_command: 'kismet --linux-ksrc=3Dlinux -a=3Dx=
86_64' }]
+                    reproduce_command: 'make ARCH=3Dx86_64 olddefconfig' }]
=20
   define_kbuild_bisect_queue_spec('bisect_kismet', 'kbuild_bisect_queue', =
test_options)
 end
--=20
2.25.1

