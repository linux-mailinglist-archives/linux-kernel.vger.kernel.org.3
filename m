Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816D452B06A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 04:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiERCP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 22:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiERCPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 22:15:48 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFC42185
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 19:15:45 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220518021541epoutp038c717eaad0b9eccf05de396325797ab9~wEVoBvjr82607726077epoutp03Z
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:15:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220518021541epoutp038c717eaad0b9eccf05de396325797ab9~wEVoBvjr82607726077epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652840141;
        bh=RGMnH5Mr3tLvcHqVdjOQOhEFHZ+A8PY/ydTZdiMenqU=;
        h=From:Subject:To:Cc:Date:References:From;
        b=mGskIKhsS4zRpDol8ge66xB3R1UpuU4G70Dt5ORle0D9Frh0huvpo/2WN1NOBPbWY
         5RjE7yWjuvTXuTkUj1dPXbyB0Mrk2I4i8U7FQv6xVX129a5dmKpiKwvSW6WMjI2cgC
         4B3DGnUEmYzwETRzK6CTv1CQufMG40+Sn3ZwuPt0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220518021541epcas1p17b2faad16b436055c7dbb4f78b551377~wEVnn_pSr1471414714epcas1p1C;
        Wed, 18 May 2022 02:15:41 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.133]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4L2xRH5Rgkz4x9QH; Wed, 18 May
        2022 02:15:39 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.AB.10354.BC654826; Wed, 18 May 2022 11:15:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220518021539epcas1p3449c756c4aca3c12000e2350b288a197~wEVmIQleW1011610116epcas1p3t;
        Wed, 18 May 2022 02:15:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220518021539epsmtrp1b98c28f4566624f32811498b5a8f1892~wEVmHiWfk1931719317epsmtrp11;
        Wed, 18 May 2022 02:15:39 +0000 (GMT)
X-AuditID: b6c32a38-4b5ff70000002872-99-628456cb4ea0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.61.11276.BC654826; Wed, 18 May 2022 11:15:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220518021539epsmtip2ed97f37acc89d1f7c586f462b69e6873~wEVl4oSZK1319213192epsmtip2S;
        Wed, 18 May 2022 02:15:39 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for 5.19
Organization: Samsung Electronics
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Message-ID: <3acd6c32-6e78-dfc2-3e45-84f69a7d5f36@samsung.com>
Date:   Wed, 18 May 2022 11:42:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmru7psJYkg12bdCwm3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJyrbJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsefK
        OraCMyoVW1e/YWpg/CvTxcjJISFgIrH4+BL2LkYuDiGBHYwSPfsa2CCcT4wSR/78gHK+MUos
        XP6GFaZl4ecDjBCJvYwSi9avYYZw3jNKTH59kBmkik1AS2L/ixtsILawgKbE+2dPmUBsfgFF
        ias/HgN1c3CICNhLdHzIBOllFrjAJHH53EmwXl4BO4mf53+C9bIIqEpc/DiFBcQWFQiTOLmt
        hRGiRlDi5MwnYHFmAXGJW0/mM0HY8hLb385hhrj0J7vEz8NSILskBFwkGpZoQISFJV4d38IO
        YUtJvOxvA/tfQqCZUaLhxW1GCKeHUeLosz4WiCpjif1LJzOBDGIGemb9Ln2IsKLEzt9zGSH2
        8km8+9rDCrGLV6KjTQiiRFni8oO7TBC2pMTi9k42CNtD4vKkz+wTGBVnIflmFpJvZiH5ZhbC
        4gWMLKsYxVILinPTU4sNC0zgsZ2cn7uJEZw6tSx2MM59+0HvECMTB+MhRgkOZiURXoOKhiQh
        3pTEyqrUovz4otKc1OJDjKbA8J3ILCWanA9M3nkl8YYmlgYmZkbGJhaGZoZK4ry9U08nCgmk
        J5akZqemFqQWwfQxcXBKNTCVCjyasmOlQG/fn5vyWpbCuieEBAOFzT+uOaUyY5La5ZVX1L/f
        0GSY6/X0Qvjj0L/drcLHbXa1Rdw1eFlZz/3d4PftLiX9+2kaaScfz1EzErH/vtxZ8vkxi9W5
        7I9vTfqsxnRwScYDyyN1nTtOX85Y4j/3VeJOkbfJ16xWb9l7ddvyHPapT8POtP8Or27xPvhB
        48qNHT/XHW14PiNxc22DQtbvKCaXoGiHqYbuYbdNfs35fVOofdYDn/KdjW91J39P+HxKUOQ6
        60LpH9ovZWfqWNTYiBq4mNsWPS5d+jnBevmclVN99gv3sfzcafw0Tzb67fNKabdX0VdOrPMw
        DPZZ0nL246nI1HgvN9OTTQtylFiKMxINtZiLihMBdOprJSYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvO7psJYkgzefRC0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJ4rJJ
        Sc3JLEst0rdL4MrYc2UdW8EZlYqtq98wNTD+leli5OSQEDCRWPj5AGMXIxeHkMBuRomdKy6y
        QSQkJaZdPMrcxcgBZAtLHD5cDFHzllFi4orXrCA1bAJaEvtf3ACrFxbQlHj/7CkTiM0voChx
        9cdjRpBeEQF7iY4PmSC9zAKXmCT6NvaA9fIK2En8PP8TrJdFQFXi4scpLCC2qECYxM4lj5kg
        agQlTs58AhZnFlCX+DPvEjOELS5x68l8JghbXmL72znMExgFZyFpmYWkZRaSlllIWhYwsqxi
        lEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOCS3NHYzbV33QO8TIxMF4iFGCg1lJhNeg
        oiFJiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBiaPxTfN
        NWYk9LJ5h+8pWp92fCKXwebT0cH/iiyVv5UJbzJf4vhU88STTcYsJ14v3f1tgv3npZUrmn7X
        L3m2OoLJ5LuTre3B8k9qdgcvLT9z8GueTJB5vuijTKdNU+PC2K82lTr113gra/aW5s/SsOtQ
        WHbAMnumS5XFJy9Jh6TOmqrsOVkdPjmsCbYnPjLe3R4jxRx3WkXVsTPBPHs954/GI3YhD67f
        MhbpE0rlWT+JfalpvfUOJjlNN0UdywVhrFn/Gy5ZJV2c3Z5ssXVq51Ntrc0vUvflWHmbC7HX
        3K25uDLY9fi/2mvuu/5w57++5KSoLudb8W+HMc+cysl+65kdOT9sfMW5q2pVl2i2EktxRqKh
        FnNRcSIAZpT8ffgCAAA=
X-CMS-MailID: 20220518021539epcas1p3449c756c4aca3c12000e2350b288a197
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220518021539epcas1p3449c756c4aca3c12000e2350b288a197
References: <CGME20220518021539epcas1p3449c756c4aca3c12000e2350b288a197@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.19-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.
- tag name : devfreq-next-for-5.19

Best Regards,
Chanwoo Choi


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.19

for you to fetch changes up to 26984d9d581e5049bd75091d2e789b9cc3ea12e0:

  PM / devfreq: passive: Keep cpufreq_policy for possible cpus (2022-05-17 18:24:39 +0900)

----------------------------------------------------------------
Update devfreq next for v5.19

Detailed description for this pull request:
1. Update devfreq core
- Add cpu based scaling support to passive governor. Some device like
cache might require the dynamic frequency scaling. But, it has very
tightly to cpu frequency. So that use passive governor to scale
the frequency according to current cpu frequency.

To decide the frequency of the device, the governor does one of the following:
: Derives the optimal devfreq device opp from required-opps property of
  the parent cpu opp_table.

: Scales the device frequency in proportion to the CPU frequency. So, if
  the CPUs are running at their max frequency, the device runs at its
  max frequency. If the CPUs are running at their min frequency, the
  device runs at its min frequency. It is interpolated for frequencies
  in between.

2. Update devfreq driver
- Update rk3399_dmc.c as following:
: Convert dt-binding document to YAML and deprecate unused properties.

: Use Hz units for the device-tree properties of rk3399_dmc.

: rk3399_dmc is able to set the idle time before changing the dmc clock.
  Specify idle time parameters by using nano-second unit on dt bidning.

: Add new disable-freq properties to optimize the power-saving feature
  of rk3399_dmc.

: Disable devfreq-event device on remove() to fix unbalanced
  enable-disable count.

: Use devm_pm_opp_of_add_table()

: Block PMU (Power-Management Unit) transitions when scaling frequency
  by ARM Trust Firmware in order to fix the conflict between PMU and DMC
  (Dynamic Memory Controller).
----------------------------------------------------------------

Brian Norris (15):
      dt-bindings: devfreq: rk3399_dmc: Convert to YAML
      dt-bindings: devfreq: rk3399_dmc: Deprecate unused/redundant properties
      dt-bindings: devfreq: rk3399_dmc: Fix Hz units
      dt-bindings: devfreq: rk3399_dmc: Specify idle params in nanoseconds
      dt-bindings: devfreq: rk3399_dmc: Add more disable-freq properties
      PM / devfreq: rk3399_dmc: Drop undocumented ondemand DT props
      PM / devfreq: rk3399_dmc: Drop excess timing properties
      PM / devfreq: rk3399_dmc: Use bitfield macro definitions for ODT_PD
      PM / devfreq: rk3399_dmc: Support new disable-freq properties
      PM / devfreq: rk3399_dmc: Support new *-ns properties
      PM / devfreq: rk3399_dmc: Disable edev on remove()
      PM / devfreq: rk3399_dmc: Use devm_pm_opp_of_add_table()
      PM / devfreq: rk3399_dmc: Avoid static (reused) profile
      soc: rockchip: power-domain: Manage resource conflicts with firmware
      PM / devfreq: rk3399_dmc: Block PMU during transitions

Chanwoo Choi (3):
      PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
      PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
      PM / devfreq: passive: Keep cpufreq_policy for possible cpus

Saravana Kannan (1):
      PM / devfreq: Add cpu based scaling support to passive governor

 .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 212 -----------
 .../memory-controllers/rockchip,rk3399-dmc.yaml    | 384 ++++++++++++++++++++
 drivers/devfreq/devfreq.c                          |  20 +-
 drivers/devfreq/governor.h                         |  27 ++
 drivers/devfreq/governor_passive.c                 | 403 +++++++++++++++++----
 drivers/devfreq/rk3399_dmc.c                       | 312 ++++++++--------
 drivers/soc/rockchip/pm_domains.c                  | 118 ++++++
 include/linux/devfreq.h                            |  17 +-
 include/soc/rockchip/pm_domains.h                  |  25 ++
 9 files changed, 1063 insertions(+), 455 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml
 create mode 100644 include/soc/rockchip/pm_domains.h
