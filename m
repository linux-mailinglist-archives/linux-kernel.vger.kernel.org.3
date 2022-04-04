Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F904F14E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345285AbiDDMdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345468AbiDDMdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:33:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D560625C61;
        Mon,  4 Apr 2022 05:31:37 -0700 (PDT)
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N6bo8-1o4He542nu-0186uZ; Mon, 04 Apr 2022 14:31:36 +0200
Received: by mail-wr1-f49.google.com with SMTP id d3so3455239wrb.7;
        Mon, 04 Apr 2022 05:31:35 -0700 (PDT)
X-Gm-Message-State: AOAM531neiLHb79xYyI+ZnMTEC0CNkRPxYiBYNY+bqQFpOBcTVnkqvYD
        +hLDWn7X5uGXc9y98At4Vptzlr2fiMkGYLkcjOw=
X-Google-Smtp-Source: ABdhPJz2GJq79q3Qyo4g3ouYndV7QgPwvlscsnwJ4EAH/Xeqo6NQis8ycYV3XmlWLRWXDcHiSs3sBnx6eVTbkRRcneY=
X-Received: by 2002:a5d:6505:0:b0:205:9a98:e184 with SMTP id
 x5-20020a5d6505000000b002059a98e184mr16140194wru.317.1649075495480; Mon, 04
 Apr 2022 05:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404074734.1092959-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
 <20220404092655.GR1544202@dread.disaster.area> <CAMuHMdWgqdR1o3wT9pjB=w8z=2xaDFv5DJX58-HPHOFRm3Tr8Q@mail.gmail.com>
 <CAK8P3a0QrihBR_2FQ7uZ5w2JmLjv7czfrrarCMmJOhvNdJ3p9g@mail.gmail.com>
In-Reply-To: <CAK8P3a0QrihBR_2FQ7uZ5w2JmLjv7czfrrarCMmJOhvNdJ3p9g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Apr 2022 14:31:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0wRiS03imdXk2WbGONkSSczEGdE-ue5ubF6UyyDE9dQg@mail.gmail.com>
Message-ID: <CAK8P3a0wRiS03imdXk2WbGONkSSczEGdE-ue5ubF6UyyDE9dQg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.18-rc1
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ItlKEN0a35IisDN/KPWjvcNae+cNOiuTzlzTHEbUW/CkD5eYyQU
 cNwFjqFu5kMocI+JXDaN99WxR3ktYjsTkwezYeTMnxB++qbnYYTXZeZFD0Ecp5dLf54Trie
 iQSodA8EescuH2xfAXr2s3MXsuCMmjt5bW63qXniLL0wLi+A52K8DwQzBJLo4nupiPAyi0P
 fQqOQOZGDoGJK5L52JNmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/4/8Lo3gecw=:Ih0wpIi0f6NOCq+EfNZ4S8
 YuLrENbNf1clBGw4Rlwvag+16YrDbrywiD4xkde5Qw7H3bWN3NjCl0lBI+bhMVGC5Ve3ln//C
 7xlvLz4vfUlPOa6YfqhRGpUDazNncgvhxlFA1ja1vLseZQLPhpISOIKHsl7NFiWs1vRggj1nX
 bA94h3p3Jy+xBR1fjtaUYktmHyiq7IxIRasYb94pK5nLeg4opJAReT8C6P9YvJz9eFJ6q5Q9o
 ISRe/bN+o8hn9fvc2xe3MNPHjH1Kos4nkSTLt2Bpnw8kXxZvV6iGBayQvb0tDEPa50c13+7yg
 UxEo/eI58ZH+rY/SqW2BVXhxzSrCHExwt0memsf6SGFpfslLecj7WnMtSLO75mTvSMtIj9oTc
 56QQ/GA7EWr6pHbOGzyDDPqq/2qmYc1e7tzBzo7Kmwtcha1wd+XA33ztTjlzSZblf79VFryUK
 bCo4DdO2o95vi00RVcjgMDMY6u7/RhEVpeNEo497pGsWpbVrtgGZ77VfEvYq/V5vEJxWrgle9
 b06AEt+UrX0blj4La9G0RocP8ksIttvGo75r6cORkUUnQ2H9jhLse3i/Z3w6xg1nMGJdnqbgm
 CpgJL95N9j3sf6HuVwZXcToLdRVwbdWI8jfQdv2FmrQR9EXFhF4YkuIPmv8w3ZxfTZAyBWwOp
 t+7dORRW5t7h4YfewlJWb0+CuLSVmjsiQKcTYvb14RdcCKhKXawBFGorFmsmU+zSGfpQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 1:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Apr 4, 2022 at 12:19 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Fortunately I still have gcc-5 installed on an older machine,
> > and I could reproduce the issue on amd64 with
> > "make allmodconfig fs/xfs/xfs_trace.o".
> >
> > Bisection points to commit e8c07082a810fbb9 ("Kbuild: move to
> > -std=gnu11").
> >
> > [1] gcc version 5.5.0 20171010 (Ubuntu 5.5.0-12ubuntu1
>
> Thanks for the report. I've produced it and can see that the problem
> is assigning
> the value of "(1 << 31)" to an 'unsigned long' struct member. Since this is
> a signed integer overflow, the result is technically undefined behavior,
> which gcc-5 does not accept as an integer constant.
>
> The patch below fixes it for me, but I have not checked if there are any
> other instances.

There are, this is now the patch to address arm64 allmodconfig:

diff --git a/drivers/gpu/drm/r128/r128_drv.h b/drivers/gpu/drm/r128/r128_drv.h
index 2e1bc01aa5c9..69b990639b70 100644
--- a/drivers/gpu/drm/r128/r128_drv.h
+++ b/drivers/gpu/drm/r128/r128_drv.h
@@ -291,18 +291,18 @@ extern long r128_compat_ioctl(struct file *filp,
unsigned int cmd,
  */
 #define R128_PM4_BUFFER_OFFSET 0x0700
 #define R128_PM4_BUFFER_CNTL 0x0704
-# define R128_PM4_MASK (15 << 28)
-# define R128_PM4_NONPM4 (0  << 28)
-# define R128_PM4_192PIO (1  << 28)
-# define R128_PM4_192BM (2  << 28)
-# define R128_PM4_128PIO_64INDBM (3  << 28)
-# define R128_PM4_128BM_64INDBM (4  << 28)
-# define R128_PM4_64PIO_128INDBM (5  << 28)
-# define R128_PM4_64BM_128INDBM (6  << 28)
-# define R128_PM4_64PIO_64VCBM_64INDBM (7  << 28)
-# define R128_PM4_64BM_64VCBM_64INDBM (8  << 28)
-# define R128_PM4_64PIO_64VCPIO_64INDPIO (15 << 28)
-# define R128_PM4_BUFFER_CNTL_NOUPDATE (1  << 27)
+# define R128_PM4_MASK (15u << 28)
+# define R128_PM4_NONPM4 (0u  << 28)
+# define R128_PM4_192PIO (1u  << 28)
+# define R128_PM4_192BM (2u  << 28)
+# define R128_PM4_128PIO_64INDBM (3u  << 28)
+# define R128_PM4_128BM_64INDBM (4u  << 28)
+# define R128_PM4_64PIO_128INDBM (5u  << 28)
+# define R128_PM4_64BM_128INDBM (6u  << 28)
+# define R128_PM4_64PIO_64VCBM_64INDBM (7u  << 28)
+# define R128_PM4_64BM_64VCBM_64INDBM (8u  << 28)
+# define R128_PM4_64PIO_64VCPIO_64INDPIO (15u << 28)
+# define R128_PM4_BUFFER_CNTL_NOUPDATE (1u  << 27)

 #define R128_PM4_BUFFER_WM_CNTL 0x0708
 # define R128_WMA_SHIFT 0
diff --git a/drivers/media/platform/nxp/imx-pxp.h
b/drivers/media/platform/nxp/imx-pxp.h
index 44f95c749d2e..83cdb3fd1312 100644
--- a/drivers/media/platform/nxp/imx-pxp.h
+++ b/drivers/media/platform/nxp/imx-pxp.h
@@ -579,27 +579,27 @@

 #define HW_PXP_CSC1_COEF0 (0x000001a0)

-#define BM_PXP_CSC1_COEF0_YCBCR_MODE 0x80000000
+#define BM_PXP_CSC1_COEF0_YCBCR_MODE 0x80000000u
 #define BF_PXP_CSC1_COEF0_YCBCR_MODE(v) \
- (((v) << 31) & BM_PXP_CSC1_COEF0_YCBCR_MODE)
-#define BM_PXP_CSC1_COEF0_BYPASS 0x40000000
+ (((unsigned)(v) << 31) & BM_PXP_CSC1_COEF0_YCBCR_MODE)
+#define BM_PXP_CSC1_COEF0_BYPASS 0x40000000u
 #define BF_PXP_CSC1_COEF0_BYPASS(v)  \
- (((v) << 30) & BM_PXP_CSC1_COEF0_BYPASS)
-#define BM_PXP_CSC1_COEF0_RSVD1 0x20000000
+ (((unsigned)(v) << 30) & BM_PXP_CSC1_COEF0_BYPASS)
+#define BM_PXP_CSC1_COEF0_RSVD1 0x20000000u
 #define BF_PXP_CSC1_COEF0_RSVD1(v)  \
- (((v) << 29) & BM_PXP_CSC1_COEF0_RSVD1)
+ (((unsigned)(v) << 29) & BM_PXP_CSC1_COEF0_RSVD1)
 #define BP_PXP_CSC1_COEF0_C0      18
-#define BM_PXP_CSC1_COEF0_C0 0x1FFC0000
+#define BM_PXP_CSC1_COEF0_C0 0x1FFC0000u
 #define BF_PXP_CSC1_COEF0_C0(v)  \
- (((v) << 18) & BM_PXP_CSC1_COEF0_C0)
+ (((unsigned)(v) << 18) & BM_PXP_CSC1_COEF0_C0)
 #define BP_PXP_CSC1_COEF0_UV_OFFSET      9
-#define BM_PXP_CSC1_COEF0_UV_OFFSET 0x0003FE00
+#define BM_PXP_CSC1_COEF0_UV_OFFSET 0x0003FE00u
 #define BF_PXP_CSC1_COEF0_UV_OFFSET(v)  \
- (((v) << 9) & BM_PXP_CSC1_COEF0_UV_OFFSET)
+ (((unsigned)(v) << 9) & BM_PXP_CSC1_COEF0_UV_OFFSET)
 #define BP_PXP_CSC1_COEF0_Y_OFFSET      0
-#define BM_PXP_CSC1_COEF0_Y_OFFSET 0x000001FF
+#define BM_PXP_CSC1_COEF0_Y_OFFSET 0x000001FFu
 #define BF_PXP_CSC1_COEF0_Y_OFFSET(v)  \
- (((v) << 0) & BM_PXP_CSC1_COEF0_Y_OFFSET)
+ (((unsigned)(v) << 0) & BM_PXP_CSC1_COEF0_Y_OFFSET)

 #define HW_PXP_CSC1_COEF1 (0x000001b0)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_reg.h
b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_reg.h
index 5caa75b41b73..7fa901fb5596 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_reg.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_reg.h
@@ -6196,71 +6196,71 @@
 #define HW_LOCK_RESOURCE_RECOVERY_REG 11
 #define HW_LOCK_RESOURCE_RESET 5
 #define HW_LOCK_RESOURCE_SPIO 2
-#define AEU_INPUTS_ATTN_BITS_ATC_HW_INTERRUPT (0x1<<4)
-#define AEU_INPUTS_ATTN_BITS_ATC_PARITY_ERROR (0x1<<5)
-#define AEU_INPUTS_ATTN_BITS_BRB_HW_INTERRUPT (0x1<<19)
-#define AEU_INPUTS_ATTN_BITS_BRB_PARITY_ERROR (0x1<<18)
-#define AEU_INPUTS_ATTN_BITS_CCM_HW_INTERRUPT (0x1<<31)
-#define AEU_INPUTS_ATTN_BITS_CCM_PARITY_ERROR (0x1<<30)
-#define AEU_INPUTS_ATTN_BITS_CDU_HW_INTERRUPT (0x1<<9)
-#define AEU_INPUTS_ATTN_BITS_CDU_PARITY_ERROR (0x1<<8)
-#define AEU_INPUTS_ATTN_BITS_CFC_HW_INTERRUPT (0x1<<7)
-#define AEU_INPUTS_ATTN_BITS_CFC_PARITY_ERROR (0x1<<6)
-#define AEU_INPUTS_ATTN_BITS_CSDM_HW_INTERRUPT (0x1<<29)
-#define AEU_INPUTS_ATTN_BITS_CSDM_PARITY_ERROR (0x1<<28)
-#define AEU_INPUTS_ATTN_BITS_CSEMI_HW_INTERRUPT (0x1<<1)
-#define AEU_INPUTS_ATTN_BITS_CSEMI_PARITY_ERROR (0x1<<0)
-#define AEU_INPUTS_ATTN_BITS_DEBUG_PARITY_ERROR (0x1<<18)
-#define AEU_INPUTS_ATTN_BITS_DMAE_HW_INTERRUPT (0x1<<11)
-#define AEU_INPUTS_ATTN_BITS_DMAE_PARITY_ERROR (0x1<<10)
-#define AEU_INPUTS_ATTN_BITS_DOORBELLQ_HW_INTERRUPT (0x1<<13)
-#define AEU_INPUTS_ATTN_BITS_DOORBELLQ_PARITY_ERROR (0x1<<12)
-#define AEU_INPUTS_ATTN_BITS_GPIO0_FUNCTION_0 (0x1<<2)
-#define AEU_INPUTS_ATTN_BITS_IGU_PARITY_ERROR (0x1<<12)
-#define AEU_INPUTS_ATTN_BITS_MCP_LATCHED_ROM_PARITY (0x1<<28)
-#define AEU_INPUTS_ATTN_BITS_MCP_LATCHED_SCPAD_PARITY (0x1<<31)
-#define AEU_INPUTS_ATTN_BITS_MCP_LATCHED_UMP_RX_PARITY (0x1<<29)
-#define AEU_INPUTS_ATTN_BITS_MCP_LATCHED_UMP_TX_PARITY (0x1<<30)
-#define AEU_INPUTS_ATTN_BITS_MISC_HW_INTERRUPT (0x1<<15)
-#define AEU_INPUTS_ATTN_BITS_MISC_PARITY_ERROR (0x1<<14)
-#define AEU_INPUTS_ATTN_BITS_NIG_PARITY_ERROR (0x1<<14)
-#define AEU_INPUTS_ATTN_BITS_PARSER_PARITY_ERROR (0x1<<20)
-#define AEU_INPUTS_ATTN_BITS_PBCLIENT_HW_INTERRUPT (0x1<<31)
-#define AEU_INPUTS_ATTN_BITS_PBCLIENT_PARITY_ERROR (0x1<<30)
-#define AEU_INPUTS_ATTN_BITS_PBF_PARITY_ERROR (0x1<<0)
-#define AEU_INPUTS_ATTN_BITS_PGLUE_HW_INTERRUPT (0x1<<2)
-#define AEU_INPUTS_ATTN_BITS_PGLUE_PARITY_ERROR (0x1<<3)
-#define AEU_INPUTS_ATTN_BITS_PXPPCICLOCKCLIENT_HW_INTERRUPT (0x1<<5)
-#define AEU_INPUTS_ATTN_BITS_PXPPCICLOCKCLIENT_PARITY_ERROR (0x1<<4)
-#define AEU_INPUTS_ATTN_BITS_PXP_HW_INTERRUPT (0x1<<3)
-#define AEU_INPUTS_ATTN_BITS_PXP_PARITY_ERROR (0x1<<2)
-#define AEU_INPUTS_ATTN_BITS_QM_HW_INTERRUPT (0x1<<3)
-#define AEU_INPUTS_ATTN_BITS_QM_PARITY_ERROR (0x1<<2)
-#define AEU_INPUTS_ATTN_BITS_SEARCHER_PARITY_ERROR (0x1<<22)
-#define AEU_INPUTS_ATTN_BITS_SPIO5 (0x1<<15)
-#define AEU_INPUTS_ATTN_BITS_TCM_HW_INTERRUPT (0x1<<27)
-#define AEU_INPUTS_ATTN_BITS_TCM_PARITY_ERROR (0x1<<26)
-#define AEU_INPUTS_ATTN_BITS_TIMERS_HW_INTERRUPT (0x1<<5)
-#define AEU_INPUTS_ATTN_BITS_TIMERS_PARITY_ERROR (0x1<<4)
-#define AEU_INPUTS_ATTN_BITS_TSDM_HW_INTERRUPT (0x1<<25)
-#define AEU_INPUTS_ATTN_BITS_TSDM_PARITY_ERROR (0x1<<24)
-#define AEU_INPUTS_ATTN_BITS_TSEMI_HW_INTERRUPT (0x1<<29)
-#define AEU_INPUTS_ATTN_BITS_TSEMI_PARITY_ERROR (0x1<<28)
-#define AEU_INPUTS_ATTN_BITS_UCM_HW_INTERRUPT (0x1<<23)
-#define AEU_INPUTS_ATTN_BITS_UCM_PARITY_ERROR (0x1<<22)
-#define AEU_INPUTS_ATTN_BITS_UPB_HW_INTERRUPT (0x1<<27)
-#define AEU_INPUTS_ATTN_BITS_UPB_PARITY_ERROR (0x1<<26)
-#define AEU_INPUTS_ATTN_BITS_USDM_HW_INTERRUPT (0x1<<21)
-#define AEU_INPUTS_ATTN_BITS_USDM_PARITY_ERROR (0x1<<20)
-#define AEU_INPUTS_ATTN_BITS_USEMI_HW_INTERRUPT (0x1<<25)
-#define AEU_INPUTS_ATTN_BITS_USEMI_PARITY_ERROR (0x1<<24)
-#define AEU_INPUTS_ATTN_BITS_VAUX_PCI_CORE_PARITY_ERROR (0x1<<16)
-#define AEU_INPUTS_ATTN_BITS_XCM_HW_INTERRUPT (0x1<<9)
-#define AEU_INPUTS_ATTN_BITS_XCM_PARITY_ERROR (0x1<<8)
-#define AEU_INPUTS_ATTN_BITS_XSDM_HW_INTERRUPT (0x1<<7)
-#define AEU_INPUTS_ATTN_BITS_XSDM_PARITY_ERROR (0x1<<6)
-#define AEU_INPUTS_ATTN_BITS_XSEMI_HW_INTERRUPT (0x1<<11)
-#define AEU_INPUTS_ATTN_BITS_XSEMI_PARITY_ERROR (0x1<<10)
+#define AEU_INPUTS_ATTN_BITS_ATC_HW_INTERRUPT BIT(4)
+#define AEU_INPUTS_ATTN_BITS_ATC_PARITY_ERROR BIT(5)
+#define AEU_INPUTS_ATTN_BITS_BRB_HW_INTERRUPT BIT(19)
+#define AEU_INPUTS_ATTN_BITS_BRB_PARITY_ERROR BIT(18)
+#define AEU_INPUTS_ATTN_BITS_CCM_HW_INTERRUPT BIT(31)
+#define AEU_INPUTS_ATTN_BITS_CCM_PARITY_ERROR BIT(30)
+#define AEU_INPUTS_ATTN_BITS_CDU_HW_INTERRUPT BIT(9)
+#define AEU_INPUTS_ATTN_BITS_CDU_PARITY_ERROR BIT(8)
+#define AEU_INPUTS_ATTN_BITS_CFC_HW_INTERRUPT BIT(7)
+#define AEU_INPUTS_ATTN_BITS_CFC_PARITY_ERROR BIT(6)
+#define AEU_INPUTS_ATTN_BITS_CSDM_HW_INTERRUPT BIT(29)
+#define AEU_INPUTS_ATTN_BITS_CSDM_PARITY_ERROR BIT(28)
+#define AEU_INPUTS_ATTN_BITS_CSEMI_HW_INTERRUPT BIT(1)
+#define AEU_INPUTS_ATTN_BITS_CSEMI_PARITY_ERROR BIT(0)
+#define AEU_INPUTS_ATTN_BITS_DEBUG_PARITY_ERROR BIT(18)
+#define AEU_INPUTS_ATTN_BITS_DMAE_HW_INTERRUPT BIT(11)
+#define AEU_INPUTS_ATTN_BITS_DMAE_PARITY_ERROR BIT(10)
+#define AEU_INPUTS_ATTN_BITS_DOORBELLQ_HW_INTERRUPT BIT(13)
+#define AEU_INPUTS_ATTN_BITS_DOORBELLQ_PARITY_ERROR BIT(12)
+#define AEU_INPUTS_ATTN_BITS_GPIO0_FUNCTION_0 BIT(2)
+#define AEU_INPUTS_ATTN_BITS_IGU_PARITY_ERROR BIT(12)
+#define AEU_INPUTS_ATTN_BITS_MCP_LATCHED_ROM_PARITY BIT(28)
+#define AEU_INPUTS_ATTN_BITS_MCP_LATCHED_SCPAD_PARITY BIT(31)
+#define AEU_INPUTS_ATTN_BITS_MCP_LATCHED_UMP_RX_PARITY BIT(29)
+#define AEU_INPUTS_ATTN_BITS_MCP_LATCHED_UMP_TX_PARITY BIT(30)
+#define AEU_INPUTS_ATTN_BITS_MISC_HW_INTERRUPT BIT(15)
+#define AEU_INPUTS_ATTN_BITS_MISC_PARITY_ERROR BIT(14)
+#define AEU_INPUTS_ATTN_BITS_NIG_PARITY_ERROR BIT(14)
+#define AEU_INPUTS_ATTN_BITS_PARSER_PARITY_ERROR BIT(20)
+#define AEU_INPUTS_ATTN_BITS_PBCLIENT_HW_INTERRUPT BIT(31)
+#define AEU_INPUTS_ATTN_BITS_PBCLIENT_PARITY_ERROR BIT(30)
+#define AEU_INPUTS_ATTN_BITS_PBF_PARITY_ERROR BIT(0)
+#define AEU_INPUTS_ATTN_BITS_PGLUE_HW_INTERRUPT BIT(2)
+#define AEU_INPUTS_ATTN_BITS_PGLUE_PARITY_ERROR BIT(3)
+#define AEU_INPUTS_ATTN_BITS_PXPPCICLOCKCLIENT_HW_INTERRUPT BIT(5)
+#define AEU_INPUTS_ATTN_BITS_PXPPCICLOCKCLIENT_PARITY_ERROR BIT(4)
+#define AEU_INPUTS_ATTN_BITS_PXP_HW_INTERRUPT BIT(3)
+#define AEU_INPUTS_ATTN_BITS_PXP_PARITY_ERROR BIT(2)
+#define AEU_INPUTS_ATTN_BITS_QM_HW_INTERRUPT BIT(3)
+#define AEU_INPUTS_ATTN_BITS_QM_PARITY_ERROR BIT(2)
+#define AEU_INPUTS_ATTN_BITS_SEARCHER_PARITY_ERROR BIT(22)
+#define AEU_INPUTS_ATTN_BITS_SPIO5 BIT(15)
+#define AEU_INPUTS_ATTN_BITS_TCM_HW_INTERRUPT BIT(27)
+#define AEU_INPUTS_ATTN_BITS_TCM_PARITY_ERROR BIT(26)
+#define AEU_INPUTS_ATTN_BITS_TIMERS_HW_INTERRUPT BIT(5)
+#define AEU_INPUTS_ATTN_BITS_TIMERS_PARITY_ERROR BIT(4)
+#define AEU_INPUTS_ATTN_BITS_TSDM_HW_INTERRUPT BIT(25)
+#define AEU_INPUTS_ATTN_BITS_TSDM_PARITY_ERROR BIT(24)
+#define AEU_INPUTS_ATTN_BITS_TSEMI_HW_INTERRUPT BIT(29)
+#define AEU_INPUTS_ATTN_BITS_TSEMI_PARITY_ERROR BIT(28)
+#define AEU_INPUTS_ATTN_BITS_UCM_HW_INTERRUPT BIT(23)
+#define AEU_INPUTS_ATTN_BITS_UCM_PARITY_ERROR BIT(22)
+#define AEU_INPUTS_ATTN_BITS_UPB_HW_INTERRUPT BIT(27)
+#define AEU_INPUTS_ATTN_BITS_UPB_PARITY_ERROR BIT(26)
+#define AEU_INPUTS_ATTN_BITS_USDM_HW_INTERRUPT BIT(21)
+#define AEU_INPUTS_ATTN_BITS_USDM_PARITY_ERROR BIT(20)
+#define AEU_INPUTS_ATTN_BITS_USEMI_HW_INTERRUPT BIT(25)
+#define AEU_INPUTS_ATTN_BITS_USEMI_PARITY_ERROR BIT(24)
+#define AEU_INPUTS_ATTN_BITS_VAUX_PCI_CORE_PARITY_ERROR BIT(16)
+#define AEU_INPUTS_ATTN_BITS_XCM_HW_INTERRUPT BIT(9)
+#define AEU_INPUTS_ATTN_BITS_XCM_PARITY_ERROR BIT(8)
+#define AEU_INPUTS_ATTN_BITS_XSDM_HW_INTERRUPT BIT(7)
+#define AEU_INPUTS_ATTN_BITS_XSDM_PARITY_ERROR BIT(6)
+#define AEU_INPUTS_ATTN_BITS_XSEMI_HW_INTERRUPT BIT(11)
+#define AEU_INPUTS_ATTN_BITS_XSEMI_PARITY_ERROR BIT(10)

 #define AEU_INPUTS_ATTN_BITS_GPIO3_FUNCTION_0 (0x1<<5)
 #define AEU_INPUTS_ATTN_BITS_GPIO3_FUNCTION_1 (0x1<<9)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index ba3c159111d3..a8ec60a0d8a1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -557,7 +557,7 @@ enum brcmf_sdio_frmtype {
  BRCMF_SDIO_FT_SUB,
 };

-#define SDIOD_DRVSTR_KEY(chip, pmu)     (((chip) << 16) | (pmu))
+#define SDIOD_DRVSTR_KEY(chip, pmu)     (((u32)(chip) << 16) | (pmu))

 /* SDIO Pad drive strength to select value mappings */
 struct sdiod_drive_str {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index 8a22ee581674..ab59a1533c02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -77,13 +77,13 @@ mt76x2e_probe(struct pci_dev *pdev, const struct
pci_device_id *id)
  /* Fix up ASPM configuration */

  /* RG_SSUSB_G1_CDR_BIR_LTR = 0x9 */
- mt76_rmw_field(dev, 0x15a10, 0x1f << 16, 0x9);
+ mt76_rmw_field(dev, 0x15a10, 0x1fu << 16, 0x9);

  /* RG_SSUSB_G1_CDR_BIC_LTR = 0xf */
- mt76_rmw_field(dev, 0x15a0c, 0xf << 28, 0xf);
+ mt76_rmw_field(dev, 0x15a0c, 0xfu << 28, 0xf);

  /* RG_SSUSB_CDR_BR_PE1D = 0x3 */
- mt76_rmw_field(dev, 0x15c58, 0x3 << 6, 0x3);
+ mt76_rmw_field(dev, 0x15c58, 0x3u << 6, 0x3);

  mt76_pci_disable_aspm(pdev);

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 94ebc1ecace7..7da764322c28 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -24,12 +24,12 @@
 #define CNTL_OVER 0x1
 #define CNTL_CLEAR 0x2
 #define CNTL_EN 0x4
-#define CNTL_EN_MASK 0xFFFFFFFB
-#define CNTL_CLEAR_MASK 0xFFFFFFFD
-#define CNTL_OVER_MASK 0xFFFFFFFE
+#define CNTL_EN_MASK 0xFFFFFFFBu
+#define CNTL_CLEAR_MASK 0xFFFFFFFDu
+#define CNTL_OVER_MASK 0xFFFFFFFEu

 #define CNTL_CSV_SHIFT 24
-#define CNTL_CSV_MASK (0xFF << CNTL_CSV_SHIFT)
+#define CNTL_CSV_MASK (0xFFu << CNTL_CSV_SHIFT)

 #define EVENT_CYCLES_ID 0
 #define EVENT_CYCLES_COUNTER 0
@@ -416,7 +416,7 @@ static void ddr_perf_counter_enable(struct ddr_pmu
*pmu, int config,
    int counter, bool enable)
 {
  u8 reg = counter * 4 + COUNTER_CNTL;
- int val;
+ u32 val;

  if (enable) {
  /*
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index f849e7c9d428..9df966c6558a 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -116,12 +116,12 @@ enum {
 #define get_target_number(x) (x%AAC_MAX_TARGETS)

 /* Thor AIF events */
-#define SA_AIF_HOTPLUG (1<<1)
-#define SA_AIF_HARDWARE (1<<2)
-#define SA_AIF_PDEV_CHANGE (1<<4)
-#define SA_AIF_LDEV_CHANGE (1<<5)
-#define SA_AIF_BPSTAT_CHANGE (1<<30)
-#define SA_AIF_BPCFG_CHANGE (1<<31)
+#define SA_AIF_HOTPLUG BIT(1)
+#define SA_AIF_HARDWARE BIT(2)
+#define SA_AIF_PDEV_CHANGE BIT(4)
+#define SA_AIF_LDEV_CHANGE BIT(5)
+#define SA_AIF_BPSTAT_CHANGE BIT(30)
+#define SA_AIF_BPCFG_CHANGE BIT(31)

 #define HBA_MAX_SG_EMBEDDED 28
 #define HBA_MAX_SG_SEPARATE 90
diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index a7ff0e5b5494..afb28efd77c2 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -240,8 +240,8 @@ enum {
 #define UIC_ARG_MPHY_TX_GEN_SEL_INDEX(lane) (lane)
 #define UIC_ARG_MPHY_RX_GEN_SEL_INDEX(lane) (PA_MAXDATALANES + (lane))

-#define UIC_ARG_MIB_SEL(attr, sel) ((((attr) & 0xFFFF) << 16) |\
- ((sel) & 0xFFFF))
+#define UIC_ARG_MIB_SEL(attr, sel) ((((attr) & 0xFFFFu) << 16) |\
+ ((sel) & 0xFFFFu))
 #define UIC_ARG_MIB(attr) UIC_ARG_MIB_SEL(attr, 0)
 #define UIC_ARG_ATTR_TYPE(t) (((t) & 0xFF) << 16)
 #define UIC_GET_ATTR_ID(v) (((v) >> 16) & 0xFFFF)
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index edcb6254fa6a..762348973e8c 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -22,28 +22,28 @@ struct xfs_buf;

 #define XFS_BUF_DADDR_NULL ((xfs_daddr_t) (-1LL))

-#define XBF_READ (1 << 0) /* buffer intended for reading from device */
-#define XBF_WRITE (1 << 1) /* buffer intended for writing to device */
-#define XBF_READ_AHEAD (1 << 2) /* asynchronous read-ahead */
-#define XBF_NO_IOACCT (1 << 3) /* bypass I/O accounting (non-LRU bufs) */
-#define XBF_ASYNC (1 << 4) /* initiator will not wait for completion */
-#define XBF_DONE (1 << 5) /* all pages in the buffer uptodate */
-#define XBF_STALE (1 << 6) /* buffer has been staled, do not find it */
-#define XBF_WRITE_FAIL (1 << 7) /* async writes have failed on this buffer */
+#define XBF_READ (1ul << 0) /* buffer intended for reading from device */
+#define XBF_WRITE (1ul << 1) /* buffer intended for writing to device */
+#define XBF_READ_AHEAD (1ul << 2) /* asynchronous read-ahead */
+#define XBF_NO_IOACCT (1ul << 3) /* bypass I/O accounting (non-LRU bufs) */
+#define XBF_ASYNC (1ul << 4) /* initiator will not wait for completion */
+#define XBF_DONE (1ul << 5) /* all pages in the buffer uptodate */
+#define XBF_STALE (1ul << 6) /* buffer has been staled, do not find it */
+#define XBF_WRITE_FAIL (1ul << 7) /* async writes have failed on this buffer */

 /* buffer type flags for write callbacks */
-#define _XBF_INODES (1 << 16)/* inode buffer */
-#define _XBF_DQUOTS (1 << 17)/* dquot buffer */
-#define _XBF_LOGRECOVERY (1 << 18)/* log recovery buffer */
+#define _XBF_INODES (1ul << 16)/* inode buffer */
+#define _XBF_DQUOTS (1ul << 17)/* dquot buffer */
+#define _XBF_LOGRECOVERY (1ul << 18)/* log recovery buffer */

 /* flags used only internally */
-#define _XBF_PAGES (1 << 20)/* backed by refcounted pages */
-#define _XBF_KMEM (1 << 21)/* backed by heap memory */
-#define _XBF_DELWRI_Q (1 << 22)/* buffer on a delwri queue */
+#define _XBF_PAGES (1ul << 20)/* backed by refcounted pages */
+#define _XBF_KMEM (1ul << 21)/* backed by heap memory */
+#define _XBF_DELWRI_Q (1ul << 22)/* buffer on a delwri queue */

 /* flags used only as arguments to access routines */
-#define XBF_TRYLOCK (1 << 30)/* lock requested, but do not wait */
-#define XBF_UNMAPPED (1 << 31)/* do not map the buffer */
+#define XBF_TRYLOCK (1ul << 30)/* lock requested, but do not wait */
+#define XBF_UNMAPPED (1ul << 31)/* do not map the buffer */

 typedef unsigned int xfs_buf_flags_t;

diff --git a/include/linux/mlx5/port.h b/include/linux/mlx5/port.h
index 28a928b0684b..f175d5bb601e 100644
--- a/include/linux/mlx5/port.h
+++ b/include/linux/mlx5/port.h
@@ -141,7 +141,7 @@ enum mlx5_ptys_width {
  MLX5_PTYS_WIDTH_12X = 1 << 4,
 };

-#define MLX5E_PROT_MASK(link_mode) (1 << link_mode)
+#define MLX5E_PROT_MASK(link_mode) BIT(link_mode)
 #define MLX5_GET_ETH_PROTO(reg, out, ext, field) \
  (ext ? MLX5_GET(reg, out, ext_##field) : \
  MLX5_GET(reg, out, field))
diff --git a/include/linux/usb/pd_bdo.h b/include/linux/usb/pd_bdo.h
index 033fe3e17141..f0ad5ce8c8a0 100644
--- a/include/linux/usb/pd_bdo.h
+++ b/include/linux/usb/pd_bdo.h
@@ -7,16 +7,16 @@
 #define __LINUX_USB_PD_BDO_H

 /* BDO : BIST Data Object */
-#define BDO_MODE_RECV (0 << 28)
-#define BDO_MODE_TRANSMIT (1 << 28)
-#define BDO_MODE_COUNTERS (2 << 28)
-#define BDO_MODE_CARRIER0 (3 << 28)
-#define BDO_MODE_CARRIER1 (4 << 28)
-#define BDO_MODE_CARRIER2 (5 << 28)
-#define BDO_MODE_CARRIER3 (6 << 28)
-#define BDO_MODE_EYE (7 << 28)
-#define BDO_MODE_TESTDATA (8 << 28)
+#define BDO_MODE_RECV (0u << 28)
+#define BDO_MODE_TRANSMIT (1u << 28)
+#define BDO_MODE_COUNTERS (2u << 28)
+#define BDO_MODE_CARRIER0 (3u << 28)
+#define BDO_MODE_CARRIER1 (4u << 28)
+#define BDO_MODE_CARRIER2 (5u << 28)
+#define BDO_MODE_CARRIER3 (6u << 28)
+#define BDO_MODE_EYE (7u << 28)
+#define BDO_MODE_TESTDATA (8u << 28)

-#define BDO_MODE_MASK(mode) ((mode) & 0xf0000000)
+#define BDO_MODE_MASK(mode) ((mode) & 0xf0000000u)

 #endif
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 167834133b9b..b8359a0aa008 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -8,7 +8,7 @@
  */

 /* handling of USB vendor/product ID pairs as 32-bit numbers */
-#define USB_ID(vendor, product) (((vendor) << 16) | (product))
+#define USB_ID(vendor, product) (((unsigned int)(vendor) << 16) | (product))
 #define USB_ID_VENDOR(id) ((id) >> 16)
 #define USB_ID_PRODUCT(id) ((u16)(id))
