Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E83572CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiGMEvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiGMEvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:51:48 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C707AD84F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:51:47 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220713045145epoutp02a765a270b44303392cd978e35efec309~BSl3vI7u_2389123891epoutp02E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:51:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220713045145epoutp02a765a270b44303392cd978e35efec309~BSl3vI7u_2389123891epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657687905;
        bh=TblPlY55/EOOD018/ryeW2448bsOy0lHAL2yF5l+2HA=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=kttSIqGqej2XqVJtGTRxXgxbJtP2fUMBgbbrf9iTMQD9YjgTafmU54lYqeiNR4LVv
         UIOJzZJrVTH3edeaIqZoqvKk3QJ7c0XppcCpMPThC8BucdttNQava98uUZsfzfdbes
         EvCoHBetHniHn0x55qHqqA7RuocgrMScCOfbrHq4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220713045144epcas1p1a143f2a35bb52c2ce776729d99c2a19e~BSl3Kw1kw3208932089epcas1p1O;
        Wed, 13 Jul 2022 04:51:44 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LjQFW4v0dz4x9Pw; Wed, 13 Jul
        2022 04:51:43 +0000 (GMT)
X-AuditID: b6c32a35-71dff700000025b9-72-62ce4f5f8835
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.CE.09657.F5F4EC26; Wed, 13 Jul 2022 13:51:43 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 0/4] Add Samsung system manager and secure service
Reply-To: dj76.yang@samsung.com
Sender: Dongjin Yang <dj76.yang@samsung.com>
From:   Dongjin Yang <dj76.yang@samsung.com>
To:     "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220713045143epcms1p5483300a3cf9ed97308a1bcfe5b889a02@epcms1p5>
Date:   Wed, 13 Jul 2022 13:51:43 +0900
X-CMS-MailID: 20220713045143epcms1p5483300a3cf9ed97308a1bcfe5b889a02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmnm68/7kkgz+nVC1O73/HYvHykKbF
        /CPnWC12z1jOZDFz6hlmi4XTljNaPD80i9ni5ax7bBZH3nxktrj/9Sijxf7jK5ksLu+aw2Zx
        bnGmReveI+wWdw6fZXHg97i+LsBj06pONo871/awebzfd5XNo2/LKkaPz5vkAtiism0yUhNT
        UosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5WUihLzCkFCgUk
        Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnzLscUbCS
        t+Le7sAGxpecXYwcHBICJhJ9bbpdjFwcQgI7GCW6W0+wgMR5BQQl/u4Q7mLk5BAWcJJ4d3Un
        G0hYSEBe4vPESoiwjkTH26dg1WwCWhKz+xNBpogIfGaUeLztMTuIwyxwhFmi4chcNpAGCQFe
        iRntIA0gtrTE9uVbGSFsDYkfy3qZIWxRiZur37LD2O+PzYeqEZFovXcWqkZQ4sHP3VBxKYlH
        zQeg7GqJc+29YIslBBoYJQ5+3sgG8aO+xI7rxiA1vAK+ElPW7mIFCbMIqEpMXJIE0eoicaXj
        I9iZzEAvbn87hxmkhFlAU2L9Ln2IIcoSR26xwDzSsPE3OzqbWYBP4t3XHlaY+I55T5ggbGWJ
        z82voXolJRZPnsk8gVFpFiKYZyHZOwth7wJG5lWMYqkFxbnpqcWGBYbwaE3Oz93ECE61WqY7
        GCe+/aB3iJGJg/EQowQHs5II75+zp5KEeFMSK6tSi/Lji0pzUosPMZoCPTyRWUo0OR+Y7PNK
        4g1NLA1MzIxMTQ0NLEyUxHlXTTudKCSQnliSmp2aWpBaBNPHxMEp1cD08OfDA3mXJrClcWw4
        o7MlqEin07MkMT/ddoHhg+4NUjOdTPJv/7TI3XamyN5Wy+d5FovN7H1S7bxqPKkzrwU55m18
        x9m3dRbvLMPDp3e/KTSffqh4/ZM1n5JP7mtt8tc+/33ytinCKyXffZ64tzggJ3pvya3nSV8V
        Xlw/GxFd1WPxaM2z3SlbLaUZHyy/rrmYc/XMdVohvyQ4CrWyxX9mLM7N7v7DoDvDTSwgvtp6
        01Pu/bwH526tMlqdGFNq9YQpcLLJfvnSpRe0eP9+v3x61ZQYvYbqtbMlm99xfPk46Ur16it8
        avJOeTbTHghXrt73IsbDVH6XxAKR3M6Wrys5LL4u+LKqRsnMkXPemtIlSizFGYmGWsxFxYkA
        Dhugxz4EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713045143epcms1p5483300a3cf9ed97308a1bcfe5b889a02
References: <CGME20220713045143epcms1p5483300a3cf9ed97308a1bcfe5b889a02@epcms1p5>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Samsung System manager driver and Secure Service code.
Samsung System manager is for SoCs produced by Samsung Foundry
to provide system read/write request by System Manager API.
Samsung Secure service is for SoCs produced by Samsung Foundry
to provide secure monitor service using Trusted Foundations.

Dongjin Yang (4):
  dt-bindings: firmware: Add bindings for Samsung smc
  firmware: Samsung: Add secure monitor driver
  dt-bindings: mfd: Add bindings for Samsung SysMgr
  mfd: Samsung: Add Samsung sysmgr driver

 .../bindings/firmware/samsung,smccc-svc.yaml       |  31 ++++
 .../devicetree/bindings/mfd/samsung,sys-mgr.yaml   |  42 ++++++
 MAINTAINERS                                        |   6 +
 drivers/firmware/Kconfig                           |  11 ++
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/samsung-smc-svc.c                 | 154 +++++++++++++++++++
 drivers/mfd/Kconfig                                |  11 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/samsung-sysmgr.c                       | 167 +++++++++++++++++++++
 include/linux/firmware/samsung-smc-svc.h           |  59 ++++++++
 include/linux/mfd/samsung-sysmgr.h                 |  30 ++++
 11 files changed, 513 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/samsung,smccc-svc.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml
 create mode 100644 drivers/firmware/samsung-smc-svc.c
 create mode 100644 drivers/mfd/samsung-sysmgr.c
 create mode 100644 include/linux/firmware/samsung-smc-svc.h
 create mode 100644 include/linux/mfd/samsung-sysmgr.h

-- 
2.9.5
