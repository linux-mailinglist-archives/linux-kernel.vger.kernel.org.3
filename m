Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593A0547874
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiFLENs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 00:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFLENq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 00:13:46 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5BD53E0B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 21:13:41 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220612041335epoutp03ba0fc6affdaf8d955b082f1ec0a36ebb~3xEtLUZ-x0606406064epoutp034
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 04:13:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220612041335epoutp03ba0fc6affdaf8d955b082f1ec0a36ebb~3xEtLUZ-x0606406064epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655007215;
        bh=SJZQOAHJw3wbHSdszVvP/HGvMn1TKA11C94/I9FoI+k=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=D75/PKXZFEhYmAeAYlgMuBpictGXpcIcf5N6uElSMNavATs4owTmHNOSdrrPEuhve
         DzYVkeFUCy+2yE3xvh1DjtptoYYaQdjPVbARJPNPqffMHQawPMZuleLDnxlE3iQ9lN
         EsyX3kWPs3qpQgkJit7vh8efJb5j/5f6ttjW+BcM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220612041334epcas5p3a08a1c6c22a7090207d108a4cd4675b9~3xEsVkV6q0380503805epcas5p3f;
        Sun, 12 Jun 2022 04:13:34 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LLLsm60ssz4x9Pp; Sun, 12 Jun
        2022 04:13:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.82.09762.CE765A26; Sun, 12 Jun 2022 13:13:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220612041331epcas5p1ad8aa893e7278112eeb6759979d4aff6~3xEpUKaB_0735007350epcas5p1J;
        Sun, 12 Jun 2022 04:13:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220612041331epsmtrp2331d1f31e44d95f85fe307f5f7be3597~3xEpTbX3m0289902899epsmtrp2U;
        Sun, 12 Jun 2022 04:13:31 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-94-62a567ec37c6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.F3.11276.BE765A26; Sun, 12 Jun 2022 13:13:31 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220612041330epsmtip2a0eadb2a0b8ac42bcc0320ad743e3f77~3xEoMzLmd0555805558epsmtip2B;
        Sun, 12 Jun 2022 04:13:30 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'kernel test robot'" <lkp@intel.com>
Cc:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        "'Chanho Park'" <chanho61.park@samsung.com>,
        "'Bharat Uppal'" <bharat.uppal@samsung.com>
In-Reply-To: <202206120755.03gKC0ne-lkp@intel.com>
Subject: RE: [mkp-scsi:for-next 31/41]
 drivers/phy/samsung/phy-fsd-ufs.c:50:3: error: field designator 'cfgs' does
 not refer to any field in type 'const struct samsung_ufs_phy_drvdata'; did
 you mean 'cfg'?
Date:   Sun, 12 Jun 2022 09:43:29 +0530
Message-ID: <000001d87e12$c6962770$53c27650$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEQai/Pc/D7KWC/Dc1oiNsuf0vQXwHf6YGgrsxP5xA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmuu6b9KVJBpuadS2uvbzAbnF5v7bF
        2e5rjBaXd81hs3jV/IjN4smU/WwWy4//Y3Jg91i85yWTR/fsfyweLzbPZPT4+PQWi0ffllWM
        Hp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQw
        MDIFKkzIzni7VLbguGzFvz89LA2MkyW7GDk5JARMJBZMvcHUxcjFISSwm1Fi5uNOVgjnE6PE
        o43H2EGqhAS+MUo8v6QB03Hz3U4WiKK9jBKHpq9mh3BeMkq83dvNCFLFJqArsWNxGxuILSKg
        KfH3/35mkCJmgVeMEgcPvwEr4hQwkjg37xFYt7DAZUaJp7dnsIAkWARUJe7P2gp0FQcHr4Cl
        xNtOOZAwr4CgxMmZT8BKmAXkJba/ncMMcZKCxM+ny1ghlllJPN09F6pGXOLl0SNg8yUElnJI
        3P+whRGiwUViWstkdghbWOLV8S1QtpTE53d72UD2Sgh4SCz6IwURzpB4u3w9VKu9xIErc1hA
        SpiBHlu/Sx9iFZ9E7+8nTBCdvBIdbUIQ1aoSze+uskDY0hITu7tZYYY/vuQ8gVFxFpK/ZiH5
        axaS+2ch7FrAyLKKUTK1oDg3PbXYtMA4L7UcHtvJ+bmbGMHJVMt7B+OjBx/0DjEycTAeYpTg
        YFYS4Q24vShJiDclsbIqtSg/vqg0J7X4EKMpMKwnMkuJJucD03leSbyhiaWBiZmZmYmlsZmh
        kjivwP/GJCGB9MSS1OzU1ILUIpg+Jg5OqQamIvnU+/MvW1zTibz4X3bWkohLUuvCL+yc8jLj
        62n/Uo1/Lyfv4Onrr+4VXbAqga2l9Zz6n2ZVw1057F5xj1t6pjswG1scvXB1f0cch/XFhdHM
        V5XOX/gf71UgLhI/feKu/8nLn7/r78twVVgSN0slKExAsOmm0V4GLwGnH3yPH3xpTH2j0PX5
        wLtPBWuLOcP1d6dfNJNlX6vQHPPj4Y7fjw9s+Kw+Vfr6GcZ7GhffHGpMvvvHsHmDqcVdYYEN
        Z28YHLUIvLk2kX1NptCFY8vWMfzRanVUOeKccmPmy/xW3RW2FxxCk/hbd7W9Puu8c/2m88yf
        v0QITnW4ert8gcnSgwtWW03Z/aia6YWoTuvTQiWW4oxEQy3mouJEACnbtr4vBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXvd1+tIkg38XZCyuvbzAbnF5v7bF
        2e5rjBaXd81hs3jV/IjN4smU/WwWy4//Y3Jg91i85yWTR/fsfyweLzbPZPT4+PQWi0ffllWM
        Hp83yQWwRXHZpKTmZJalFunbJXBlvF0qW3BctuLfnx6WBsbJkl2MnBwSAiYSN9/tZOli5OIQ
        EtjNKNF4ejs7REJa4vrGCVC2sMTKf8/ZIYqeM0r8PtDFDJJgE9CV2LG4jQ3EFhHQlPj7fz8z
        SBGzwDtGiQdfFjGCJIQEmhklnsytBrE5BYwkzs17BDZJWOAso8SOu4dZQBIsAqoS92dtZepi
        5ODgFbCUeNspBxLmFRCUODnzCQtImFlAT6JtI9hIZgF5ie1v5zBDHKcg8fPpMlaIG6wknu6e
        ywJRIy7x8ugR9gmMwrOQTJqFMGkWkkmzkHQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeu
        l5yfu4kRHFNamjsYt6/6oHeIkYmD8RCjBAezkghvwO1FSUK8KYmVValF+fFFpTmpxYcYpTlY
        lMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwLQtf4hqr6eBQvFX/9bK3aWG362WivhcX7syY
        8MVlh5T0GfXKxOu803/HXJ/s0JEs6iW0qVk0bNKvbR0HEw4K3FKxds2VnLPY0qvp85uPamau
        579kpHnsSl8+f1tRvdgZ12/bZtTlh4rmSLTO/Ju4PuDS1L7bi5mbQhlr3n0pPpPOyvtyQara
        nCtrL16cWlgrPts8OG9Ducr5xhX7rJV9rvNOlrF7osvNPL2o9FfeqrV9D7Zr3Ol4HdXHbLSL
        +3PeQzlbjgst99UflipKq11i+stz9eP1+5JtZzVN09w13mUI667sspe94zFPzexRd3HEw6PJ
        Ez8vXLzU+7vS7a5FTa131Pkq6ytmBCXZh01WYinOSDTUYi4qTgQAN0eVAxgDAAA=
X-CMS-MailID: 20220612041331epcas5p1ad8aa893e7278112eeb6759979d4aff6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220611233355epcas5p1970bae9647eae17e20d330775b584695
References: <CGME20220611233355epcas5p1970bae9647eae17e20d330775b584695@epcas5p1.samsung.com>
        <202206120755.03gKC0ne-lkp@intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>-----Original Message-----
>From: kernel test robot [mailto:lkp@intel.com]
>Sent: Sunday, June 12, 2022 5:03 AM
>To: Alim Akhtar <alim.akhtar@samsung.com>
>Cc: llvm@lists.linux.dev; kbuild-all@lists.01.org;
linux-kernel@vger.kernel.org;
>Martin K. Petersen <martin.petersen@oracle.com>; Chanho Park
><chanho61.park@samsung.com>; Bharat Uppal
><bharat.uppal@samsung.com>
>Subject: [mkp-scsi:for-next 31/41] drivers/phy/samsung/phy-fsd-ufs.c:50:3:
>error: field designator 'cfgs' does not refer to any field in type 'const
struct
>samsung_ufs_phy_drvdata'; did you mean 'cfg'?
>
>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
for-next
>head:   b9f50e3cfd13687279f2170ff6ef5d71f6c7db11
>commit: f678ce49991950e4964cd82d3f3a8adfb63a9a70 [31/41] scsi: phy:
>samsung-ufs: Add support for FSD UFS PHY driver
>config: hexagon-randconfig-r045-20220612
>(https://protect2.fireeye.com/v1/url?k=5d7e4a21-3c05e0a8-5d7fc16e-
>74fe48600034-ee8489beaab56766&q=1&e=4cfcb9fa-8108-4551-8c4c-
>365a83dbb2ae&u=https%3A%2F%2Fdownload.01.org%2F0day-
>ci%2Farchive%2F20220612%2F202206120755.03gKC0ne-
>lkp%40intel.com%2Fconfig)
>compiler: clang version 15.0.0
>(https://protect2.fireeye.com/v1/url?k=2ec17c37-4fbad6be-2ec0f778-
>74fe48600034-5023bd0668516b05&q=1&e=4cfcb9fa-8108-4551-8c4c-
>365a83dbb2ae&u=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project
>ff4abe755279a3a47cc416ef80dbc900d9a98a19)
>reproduce (this is a W=1 build):
>        wget https://protect2.fireeye.com/v1/url?k=0f0eec04-6e75468d-
>0f0f674b-74fe48600034-eda10c46bdf9a9c9&q=1&e=4cfcb9fa-8108-4551-8c4c-
>365a83dbb2ae&u=https%3A%2F%2Fraw.githubusercontent.com%2Fintel%2Fl
>kp-tests%2Fmaster%2Fsbin%2Fmake.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        #
>https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=f67
>8ce49991950e4964cd82d3f3a8adfb63a9a70
>        git remote add mkp-scsi
>https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
>        git fetch --no-tags mkp-scsi for-next
>        git checkout f678ce49991950e4964cd82d3f3a8adfb63a9a70
>        # save the config file
>        mkdir build_dir && cp config build_dir/.config
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
>W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/phy/samsung/
>
>If you fix the issue, kindly add following tag where applicable
>Reported-by: kernel test robot <lkp@intel.com>
>
>All errors (new ones prefixed by >>):
>
>>> drivers/phy/samsung/phy-fsd-ufs.c:50:3: error: field designator 'cfgs'
does
>not refer to any field in type 'const struct samsung_ufs_phy_drvdata'; did
you
>mean 'cfg'?
>           .cfgs = fsd_ufs_phy_cfgs,
>            ^~~~
>            cfg
>   drivers/phy/samsung/phy-samsung-ufs.h:104:37: note: 'cfg' declared here
>           const struct samsung_ufs_phy_cfg **cfg;
>                

[1] " patch:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20220607072907.1
27000-3-chanho61.park@samsung.com/

changes the cfg -> cfgs , and it is merged in Linux-next.
This series was based on next-20220609

I was expecting phy driver changes will go via phy tree, where [1] is
available.

@Martin, can you please take a look?

You can just take the ufs changes (along with its device tree) and drop the
phy change or take the [1] above.


>   1 error generated.
>
>
>vim +50 drivers/phy/samsung/phy-fsd-ufs.c
>
>    48
>    49	const struct samsung_ufs_phy_drvdata fsd_ufs_phy = {
>  > 50		.cfgs = fsd_ufs_phy_cfgs,
>
>--
>0-DAY CI Kernel Test Service
>https://protect2.fireeye.com/v1/url?k=780e3ae5-1975906c-780fb1aa-
>74fe48600034-15b3e78a3eb1d3c6&q=1&e=4cfcb9fa-8108-4551-8c4c-
>365a83dbb2ae&u=https%3A%2F%2F01.org%2Flkp

