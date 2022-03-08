Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D34F4D0DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244872AbiCHCZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiCHCZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:25:12 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23C126574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:24:15 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220308022412epoutp0250be6ee359eaec9a8514e5a5469d9318~aRpy5XIav3115731157epoutp02m
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:24:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220308022412epoutp0250be6ee359eaec9a8514e5a5469d9318~aRpy5XIav3115731157epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646706252;
        bh=IFIWA4iu1KaNiCtnA0Lv/JmgmpJkNLoyAZggCCm77TI=;
        h=To:Cc:From:Subject:Date:References:From;
        b=FOr6SVtWKkZa9Y5Llnpx7UDfnJZ4uuaHjlH1zfRA6F2ZyqhW8c5gCAlrgPhfHm8lC
         Qx0nRiH0d9bvFOJNUWczp+ldz7ExvNTGsulamlxMoUIYa/kWFtlmk32V6bRdsgEcK4
         lZMeagAdCauzJQ9sAp7aFyBlS2K5bLhdR1UlTC5I=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220308022412epcas1p3a249520100f0d64a8a6507040e744f85~aRpykrR-43030130301epcas1p3S;
        Tue,  8 Mar 2022 02:24:12 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.135]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KCJzp6KkMz4x9QK; Tue,  8 Mar
        2022 02:24:06 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.D8.64085.04EB6226; Tue,  8 Mar 2022 11:24:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220308022359epcas1p2d145af3c2f462bb6e69da46663c38c95~aRpm-OPhd1455214552epcas1p2k;
        Tue,  8 Mar 2022 02:23:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220308022359epsmtrp1517404c5842ade44019c235ad5bc5769~aRpm_gsIw1863018630epsmtrp1n;
        Tue,  8 Mar 2022 02:23:59 +0000 (GMT)
X-AuditID: b6c32a35-9c3ff7000000fa55-be-6226be40a425
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.15.03370.F3EB6226; Tue,  8 Mar 2022 11:23:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220308022359epsmtip2872766a9802ac88b6a062655bfe2e2e7~aRpmwOlsL3153831538epsmtip2D;
        Tue,  8 Mar 2022 02:23:59 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.18
Organization: Samsung Electronics
Message-ID: <49839780-1b58-5a30-0e56-e02f7756a216@samsung.com>
Date:   Tue, 8 Mar 2022 11:48:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTV9dhn1qSwZ9VfBYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaje/fZCo7wVTy5O5+x
        gXE/dxcjB4eEgInEue/5XYxcHEICOxglevYdZ4RwPjFKXNz1mA3C+cwocXTDZ1aYjvWT0iHi
        uxglvn09DlX0nlHi7+vPQA4nh4iAhsTLo7dYQBLMAm8YJfZ97mQFSbAJaEnsf3EDrEhYQFOi
        efF8sDi/gKLE1R+PGUFsXgE7icerNzCB2CwCKhIPtnQzg9iiAmESJ7e1QNUISpyc+YQFxGYW
        EJe49WQ+E4QtL7H97RxmkMUSAh/ZJaY/+ATWLCHgIrHh1zs2CFtY4tXxLewQtpTEy/42doiG
        ZkaJhhe3GSGcHqCnn/WxQFQZS+xfOpkJFADMQGev36UPEVaU2Pl7LiPEZj6Jd197oGHEK9HR
        JgRRoixx+cFdJghbUmJxeyfUDR4SB+7/ZpvAqDgLyT+zkPwzC8k/sxAWL2BkWcUollpQnJue
        WmxYYAiP7uT83E2M4ESpZbqDceLbD3qHGJk4GA8xSnAwK4nw3j+vkiTEm5JYWZValB9fVJqT
        WnyI0RQYwhOZpUST84GpOq8k3tDE0sDEzMjYxMLQzFBJnHfVtNOJQgLpiSWp2ampBalFMH1M
        HJxSDUzJ/26duhS5eUNY/L7kgK4Vz4Nf83FsnsdQHn4n0MvvCNuULXffZhwJZP5raft2r02R
        7PIjmn9rZ+5y91g703rWx4UrDXwD9is1VidFHZG9x7hS7ldiX9t2sXy9nRFHT3TyWX/xy/9Q
        2XDuJZ+zeY9Xeq+zmb1Vk5ThF8HLS8MSoyfcMPJOMHO0uODZOHF+qGHRtMuL5F7I7v682b7c
        YGXbkv3TjBTttPQu9GX9+qiwtNaZq2dJVOGnrNov6/92n7h6b9JWUd2PGy85Wbxq2nvv/OsQ
        Xt9p4kumyl0u+DJVMdZXsyRPSuborYbcLXk8O/LuvMsXXjPb1/LJhTbWF+25ZY/keJ5V32R2
        f3zDSk2JpTgj0VCLuag4EQBeqOkWHQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSvK79PrUkg/X79Cwm3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAligum5TUnMyy1CJ9uwSu
        jEf37rMVHOGreHJ3PmMD437uLkYODgkBE4n1k9K7GLk4hAR2MEq0/DjO3MXICRSXlJh28Sgz
        RI2wxOHDxRA1bxklfl75ygJSIyKgIfHy6C0WkASzwBtGif41W9hBEmwCWhL7X9xgA7GFBTQl
        mhfPZwWx+QUUJa7+eMwIYvMK2Ek8Xr2BCcRmEVCReLClG2yxqECYxM4lj5kgagQlTs58AraM
        WUBd4s+8S8wQtrjErSfzmSBseYntb+cwT2AUnIWkZRaSlllIWmYhaVnAyLKKUTK1oDg3PbfY
        sMAoL7Vcrzgxt7g0L10vOT93EyM4/LW0djDuWfVB7xAjEwfjIUYJDmYlEd7751WShHhTEiur
        Uovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamAy/qL4e/3q638tV65c
        9iimduZUjQCJBVrnH+dP+LDiguh/1+vv7MtzJVev0DM+tMp245x1O6ZNULq3UMLYzJz5x9e9
        8pPif1k9ld+YwJ332Ofjn/Yrk4VLttbOfsjsV5Ax4TcPT9DSWXO57ki+z9NZfVaR08g/8fTD
        mh+RQffDedYskrGs1u3mXjBv/t5yjdl1Clcn1xY/Xt3/rzDudIhfP1fEHY2Cw5Eadn78e5gV
        Ejcdv5kYu5Gv85mcpNOyC2yrFv3c96FAysjrJxcf+y6m1ftsG84w37j0WE7183qjj4xVPIrG
        TJmXGLYeWjjLkiM+PHbxlFDpoNScw4vtN21oFX1j8Dyr78mfKwWr8l9mKrEUZyQaajEXFScC
        ADHRCzPuAgAA
X-CMS-MailID: 20220308022359epcas1p2d145af3c2f462bb6e69da46663c38c95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308022359epcas1p2d145af3c2f462bb6e69da46663c38c95
References: <CGME20220308022359epcas1p2d145af3c2f462bb6e69da46663c38c95@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.18. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.18

for you to fetch changes up to 7f3e22d689056970eee5fc5b6ec2e26d985b02c2:

  extcon: Fix some kernel-doc comments (2022-03-07 18:12:21 +0900)

----------------------------------------------------------------
Dan Carpenter (1):
      extcon: Fix extcon_get_extcon_dev() error handling

Gustavo A. R. Silva (1):
      extcon: usbc-cros-ec: Use struct_size() helper in kzalloc()

Hans de Goede (4):
      extcon: int3496: Make the driver a bit less verbose
      extcon: int3496: Request non-exclusive access to the ID GPIO
      extcon: int3496: Add support for binding to plain platform devices
      extcon: int3496: Add support for controlling Vbus through a regulator

Yang Li (1):
      extcon: Fix some kernel-doc comments

 drivers/extcon/extcon-axp288.c         |  4 +--
 drivers/extcon/extcon-intel-int3496.c  | 54 +++++++++++++++++++++++++++++-----
 drivers/extcon/extcon-usbc-cros-ec.c   |  2 +-
 drivers/extcon/extcon.c                |  8 ++++-
 drivers/power/supply/axp288_charger.c  | 17 ++++++-----
 drivers/power/supply/charger-manager.c |  7 ++---
 drivers/power/supply/max8997_charger.c | 10 +++----
 drivers/usb/dwc3/drd.c                 |  9 ++----
 drivers/usb/phy/phy-omap-otg.c         |  4 +--
 drivers/usb/typec/tcpm/fusb302.c       |  4 +--
 include/linux/extcon.h                 |  2 +-
 11 files changed, 80 insertions(+), 41 deletions(-)
