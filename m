Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F55B52F9F6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 10:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiEUIJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 04:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiEUII5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 04:08:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CDA1611C1;
        Sat, 21 May 2022 01:08:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a38so6671622pgl.9;
        Sat, 21 May 2022 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c7ATnEiBWxzHBgmdH+iHVOAqIrrFmswpu1N0IujH5qE=;
        b=L3s20sPVxmFAGVEfovbCZpePdPnhRolUkvviaRi5nvHWkviVMX4JKwLeFCaJ714wqn
         12DZRJVnvXTjVsywI8Cq5r/TYEh4+f/wPpWjIYFxjwcrGTOyaS0YHwjoIfWVhofLDN3h
         eDCUyZcsqZg5OQd9DAtsPoBSkiOltFUNO7b0z5tfEwnRIT1l8rR+cf2Iw36OC1g70sBZ
         5YWM1V+zcpTKJsVJN7fwvFkmvLYPAtRzpQxL0Z50oJZidOxjz5Z28F8+ys5o+QSzVaOB
         aC7z6PcbuMk3ti/L9Afj1tegj/R4Hfa7doISxn+KRyXIX8G+OOAhzuVuuECll3L86x/8
         WXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c7ATnEiBWxzHBgmdH+iHVOAqIrrFmswpu1N0IujH5qE=;
        b=sFt4ozS0Ix6A0dM/ihiI/1YTno56ikuet887EmQxw+vYZjaFr84Si5iiFsmBL49wI+
         dlhdXcI5I+xYSi3aTDKolCqucQnfkGwX9g2ApQklbyXOoMhLCETHMcPTfhc9o8m2DNc3
         5ppH34TwnGCAlvigy7Y/g9wviphA9mDQpYmyeS09vOp/ZqgV54HLrIoVIp5EDVY8okEv
         6jxD3vvM1bhzfM2FFaryVIubPyFwL5Y/RTI2LP9MPOBNCVOt7EghpHP85dPSOln9aQIT
         1V7vpqPYka4t4dZu+dFH9Xw/PUgd2hiLArdhTwmW/JzJoncsyTceKKcCdkuHURe7TsOs
         dfrg==
X-Gm-Message-State: AOAM533IePZ3XGEP9O3zFgdHG3AEyD+zth3wiWyBWW/nDLx1PDxFYyyv
        OKM4j2TRcVCCkLQ8MzhCb1A=
X-Google-Smtp-Source: ABdhPJyXqBazkLVfBEQYtRi13M1WwhHu1omCI7n4jN6NC/g25BcVpG+LEaDshheGjeO2TtVp0AKqug==
X-Received: by 2002:a65:6c06:0:b0:3f5:f29d:e030 with SMTP id y6-20020a656c06000000b003f5f29de030mr11703403pgu.22.1653120536150;
        Sat, 21 May 2022 01:08:56 -0700 (PDT)
Received: from localhost (subs02-180-214-232-90.three.co.id. [180.214.232.90])
        by smtp.gmail.com with ESMTPSA id z71-20020a63334a000000b003db68cb9d6esm1006167pgz.9.2022.05.21.01.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 01:08:55 -0700 (PDT)
Date:   Sat, 21 May 2022 15:08:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] arm64: Unify vertical spacing in HWCAPS
Message-ID: <YoieFI7hdJPJW5qy@debian.me>
References: <4752814a-091c-9dd5-762c-6fd1a476c4bb@gmail.com>
 <e3921517-f903-3ad5-afa4-d7959051e5dd@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3921517-f903-3ad5-afa4-d7959051e5dd@suse.cz>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 04:01:33PM +0200, Martin Liška wrote:
> Promote headings by removing intermediate blank lines.
> 
> Signed-off-by: Martin Liska <mliska@suse.cz>
> ---
>  Documentation/arm64/elf_hwcaps.rst | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
> index a8f30963e550..1e79044f51a2 100644
> --- a/Documentation/arm64/elf_hwcaps.rst
> +++ b/Documentation/arm64/elf_hwcaps.rst
> @@ -171,96 +171,73 @@ HWCAP_PACG
>      Documentation/arm64/pointer-authentication.rst.
>  
>  HWCAP2_DCPODP
> -
>      Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.
>  
>  HWCAP2_SVE2
> -
>      Functionality implied by ID_AA64ZFR0_EL1.SVEVer == 0b0001.
>  
>  HWCAP2_SVEAES
> -
>      Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0001.
>  
>  HWCAP2_SVEPMULL
> -
>      Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0010.
>  
>  HWCAP2_SVEBITPERM
> -
>      Functionality implied by ID_AA64ZFR0_EL1.BitPerm == 0b0001.
>  
>  HWCAP2_SVESHA3
> -
>      Functionality implied by ID_AA64ZFR0_EL1.SHA3 == 0b0001.
>  
>  HWCAP2_SVESM4
> -
>      Functionality implied by ID_AA64ZFR0_EL1.SM4 == 0b0001.
>  
>  HWCAP2_FLAGM2
> -
>      Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0010.
>  
>  HWCAP2_FRINT
> -
>      Functionality implied by ID_AA64ISAR1_EL1.FRINTTS == 0b0001.
>  
>  HWCAP2_SVEI8MM
> -
>      Functionality implied by ID_AA64ZFR0_EL1.I8MM == 0b0001.
>  
>  HWCAP2_SVEF32MM
> -
>      Functionality implied by ID_AA64ZFR0_EL1.F32MM == 0b0001.
>  
>  HWCAP2_SVEF64MM
> -
>      Functionality implied by ID_AA64ZFR0_EL1.F64MM == 0b0001.
>  
>  HWCAP2_SVEBF16
> -
>      Functionality implied by ID_AA64ZFR0_EL1.BF16 == 0b0001.
>  
>  HWCAP2_I8MM
> -
>      Functionality implied by ID_AA64ISAR1_EL1.I8MM == 0b0001.
>  
>  HWCAP2_BF16
> -
>      Functionality implied by ID_AA64ISAR1_EL1.BF16 == 0b0001.
>  
>  HWCAP2_DGH
> -
>      Functionality implied by ID_AA64ISAR1_EL1.DGH == 0b0001.
>  
>  HWCAP2_RNG
> -
>      Functionality implied by ID_AA64ISAR0_EL1.RNDR == 0b0001.
>  
>  HWCAP2_BTI
> -
>      Functionality implied by ID_AA64PFR0_EL1.BT == 0b0001.
>  
>  HWCAP2_MTE
> -
>      Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
>      by Documentation/arm64/memory-tagging-extension.rst.
>  
>  HWCAP2_ECV
> -
>      Functionality implied by ID_AA64MMFR0_EL1.ECV == 0b0001.
>  
>  HWCAP2_AFP
> -
>      Functionality implied by ID_AA64MFR1_EL1.AFP == 0b0001.
>  
>  HWCAP2_RPRES
> -
>      Functionality implied by ID_AA64ISAR2_EL1.RPRES == 0b0001.
>  
>  HWCAP2_MTE3
> -
>      Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0011, as described
>      by Documentation/arm64/memory-tagging-extension.rst.
>  
> -- 
> 2.36.1
> 

Hi,

Sorry for misunderstanding of this topic on my reply at [1].

After applying this patch and doing htmldocs build, I see the HTML
diff below.

diff --git a/tmp/elf_hwcaps.html b/tmp/elf_hwcaps.patched.html
index 8b0b0f83ca4f9e..d13f49faebf297 100644
--- a/tmp/elf_hwcaps.html
+++ b/tmp/elf_hwcaps.patched.html
@@ -320,101 +320,55 @@ ID_AA64ISAR1_EL1.API == 0b0001, as described by
 ID_AA64ISAR1_EL1.GPI == 0b0001, as described by
  <a class="reference internal" href="pointer-authentication.html"><span class="doc">Pointer authentication in AArch64 Linux</span></a>.</p>
   </dd>
   -</dl>
   -<p>HWCAP2_DCPODP</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.</p>
   -</div></blockquote>
   -<p>HWCAP2_SVE2</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ZFR0_EL1.SVEVer == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_SVEAES</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_SVEPMULL</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0010.</p>
   -</div></blockquote>
   -<p>HWCAP2_SVEBITPERM</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ZFR0_EL1.BitPerm == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_SVESHA3</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ZFR0_EL1.SHA3 == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_SVESM4</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ZFR0_EL1.SM4 == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_FLAGM2</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0010.</p>
   -</div></blockquote>
   -<p>HWCAP2_FRINT</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ISAR1_EL1.FRINTTS == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_SVEI8MM</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ZFR0_EL1.I8MM == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_SVEF32MM</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ZFR0_EL1.F32MM == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_SVEF64MM</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ZFR0_EL1.F64MM == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_SVEBF16</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ZFR0_EL1.BF16 == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_I8MM</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ISAR1_EL1.I8MM == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_BF16</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ISAR1_EL1.BF16 == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_DGH</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ISAR1_EL1.DGH == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_RNG</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64ISAR0_EL1.RNDR == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_BTI</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64PFR0_EL1.BT == 0b0001.</p>
   -</div></blockquote>
   -<p>HWCAP2_MTE</p>
   -<blockquote>
   -<div><p>Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
   +<dt>HWCAP2_DCPODP</dt><dd><p>Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.</p>
   +</dd>
   +<dt>HWCAP2_SVE2</dt><dd><p>Functionality implied by ID_AA64ZFR0_EL1.SVEVer == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_SVEAES</dt><dd><p>Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_SVEPMULL</dt><dd><p>Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0010.</p>
   +</dd>
   +<dt>HWCAP2_SVEBITPERM</dt><dd><p>Functionality implied by ID_AA64ZFR0_EL1.BitPerm == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_SVESHA3</dt><dd><p>Functionality implied by ID_AA64ZFR0_EL1.SHA3 == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_SVESM4</dt><dd><p>Functionality implied by ID_AA64ZFR0_EL1.SM4 == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_FLAGM2</dt><dd><p>Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0010.</p>
   +</dd>
   +<dt>HWCAP2_FRINT</dt><dd><p>Functionality implied by ID_AA64ISAR1_EL1.FRINTTS == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_SVEI8MM</dt><dd><p>Functionality implied by ID_AA64ZFR0_EL1.I8MM == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_SVEF32MM</dt><dd><p>Functionality implied by ID_AA64ZFR0_EL1.F32MM == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_SVEF64MM</dt><dd><p>Functionality implied by ID_AA64ZFR0_EL1.F64MM == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_SVEBF16</dt><dd><p>Functionality implied by ID_AA64ZFR0_EL1.BF16 == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_I8MM</dt><dd><p>Functionality implied by ID_AA64ISAR1_EL1.I8MM == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_BF16</dt><dd><p>Functionality implied by ID_AA64ISAR1_EL1.BF16 == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_DGH</dt><dd><p>Functionality implied by ID_AA64ISAR1_EL1.DGH == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_RNG</dt><dd><p>Functionality implied by ID_AA64ISAR0_EL1.RNDR == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_BTI</dt><dd><p>Functionality implied by ID_AA64PFR0_EL1.BT == 0b0001.</p>
   +</dd>
   +<dt>HWCAP2_MTE</dt><dd><p>Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
    by <a class="reference internal" href="memory-tagging-extension.html"><span class="doc">Memory Tagging Extension (MTE) in AArch64 Linux</span></a>.</p>
    -</div></blockquote>
    -<p>HWCAP2_ECV</p>
    -<blockquote>
    -<div><p>Functionality implied by ID_AA64MMFR0_EL1.ECV == 0b0001.</p>
    -</div></blockquote>
    -<p>HWCAP2_AFP</p>
    -<blockquote>
    -<div><p>Functionality implied by ID_AA64MFR1_EL1.AFP == 0b0001.</p>
    -</div></blockquote>
    -<p>HWCAP2_RPRES</p>
    -<blockquote>
    -<div><p>Functionality implied by ID_AA64ISAR2_EL1.RPRES == 0b0001.</p>
    -</div></blockquote>
    -<p>HWCAP2_MTE3</p>
    -<blockquote>
    -<div><p>Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0011, as described
    +</dd>
    +<dt>HWCAP2_ECV</dt><dd><p>Functionality implied by ID_AA64MMFR0_EL1.ECV == 0b0001.</p>
    +</dd>
    +<dt>HWCAP2_AFP</dt><dd><p>Functionality implied by ID_AA64MFR1_EL1.AFP == 0b0001.</p>
    +</dd>
    +<dt>HWCAP2_RPRES</dt><dd><p>Functionality implied by ID_AA64ISAR2_EL1.RPRES == 0b0001.</p>
    +</dd>
    +<dt>HWCAP2_MTE3</dt><dd><p>Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0011, as described
     by <a class="reference internal" href="memory-tagging-extension.html"><span class="doc">Memory Tagging Extension (MTE) in AArch64 Linux</span></a>.</p>
     -</div></blockquote>
     +</dd>
     +</dl>
      </section>
       <section id="unused-at-hwcap-bits">
        <h2>4. Unused AT_HWCAP bits<a class="headerlink" href="#unused-at-hwcap-bits" title="Permalink to this headline">¶</a></h2>

So basically this doesn't promotes HWCAP2_* as headings, but rather changes
HTML element used by them from <div> & <p> to <dl> & <dd>. Otherwise I don't
see any visual differences.

Regarding the patch subject, I don't know what unifying the vertical spacing
is, so I can't tell whether the patch is correct on this context or not.

Also, when submitting next iterations of your patch series, don't forget
to pass -v <number> to git-format-patch(1) so that the patch subject
prefix contains the correct version numbers. I gave that advice because
I don't see that this patch is sent as v2 of [2].

CCing Akira to help reviewing.

[1]: https://lore.kernel.org/linux-doc/4752814a-091c-9dd5-762c-6fd1a476c4bb@gmail.com/
[2]: https://lore.kernel.org/linux-doc/b95b3128-f010-dcba-1f6a-1a85dd2d20a5@suse.cz/

-- 
An old man doll... just what I always wanted! - Clara
