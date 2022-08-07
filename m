Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F5458BC40
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiHGSNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiHGSNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:13:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB463B6
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:13:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j8so12839386ejx.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc;
        bh=4DbdbqqYHLYjY1fnsQWsetOhJTERfsuO97ho7gqprHU=;
        b=WgpDMRTAmwcwOVfKxtC2doX1oY+haDJPhSkMHbzPPmO+RzZFwvzy6P3ngLzXYfgs2n
         dO7KCQCfr18zC/med0w1iGWVPLKqiT48DHPpd7Yb0ws850Dp7IfmL/0CERfu56TyRrK8
         gllzlpyXA/dghYPamVGZGqONK4whyJ2OM5DIcJJynoUbHxDA4qu65P3xgFK4RaMv3ZaU
         d3Wmr8KjPSJiqnR2Q/mmKKNfW9Nmn84S/QETGbunHUW377al7lmN5WcOmKX8xsFDDi49
         X5bJ3+rbtiBJaucK6SToLjI7ChH/9+Yc8YPjSkllv1/7ty+gUvIEz3/BzLaRZ66gEeS0
         qlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=4DbdbqqYHLYjY1fnsQWsetOhJTERfsuO97ho7gqprHU=;
        b=EErDudTjglL7bpSQu2aLYfHYp3wh7HroPSDGoJxexbm7YvaRZxx5cxrKIFAibo1ktZ
         yopTmnr95GGZKw1XZowuQSmn/mi4kIUqllWlfL8xf06GrbLXveVbojiMeGD3TF782Pef
         iJ/4EGigNjTY2RqFo+X+ybk+r9W4hEqeFdfyMJ9TfuoY1G7Po0SZN9v2jG/gy3Nysmeo
         HzunwP9cwT94mM9G0fYMVG9f2l/lWKYMW3+4/j6rDJhg0IG0DTYbQI+srgTkyMgKsY0h
         qVUoTwIkJcmuhka807HDPPfkuj+Z/RH2GL9iCYN4+7Otdoxe5VylNrW0vI/uZjoeLFMT
         uLcg==
X-Gm-Message-State: ACgBeo3X0Clt0G6rGg8cy3irVpFH5o1CiIKrItOHM8i6f4sfO6rMU1Sa
        KZOqmH8ofnrn5wgDlOcpAC8=
X-Google-Smtp-Source: AA6agR7ARq0IP4FbqD5slOMEUKyugAIvVmmMZpOWTNvRPu9O224fTi7e++mahIVTC2Fib6mviWTOlg==
X-Received: by 2002:a17:907:6eac:b0:730:a07f:38bb with SMTP id sh44-20020a1709076eac00b00730a07f38bbmr12045871ejc.750.1659896009528;
        Sun, 07 Aug 2022 11:13:29 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0043ba24a26casm3398622edb.23.2022.08.07.11.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:13:29 -0700 (PDT)
Date:   Sun, 7 Aug 2022 20:13:27 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] staging: vt6655: Create two base functions for four
 macros
Message-ID: <cover.1659892670.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create two base functions vt6655_mac_set_bits and vt6655_mac_clear_bits
with parameters for four multiline macros. Multiline macros are not liked
by kernel community.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

V1 -> V2: Devided vt6655_mac_en_dis_bits_u32_reg into
          vt6655_mac_set_bits and vt6655_mac_clear_bits
          Changed variable from bit_mask to mask

Philipp Hortmann (6):
  staging: vt6655: Convert macro MACvEnableProtectMD to function
  staging: vt6655: Create one function for two macros
  staging: vt6655: Rename function MACvEnableProtectMD
  staging: vt6655: Convert macro MACvDisableProtectMD
  staging: vt6655: Convert macro MACvEnableBarkerPreambleMd
  staging: vt6655: Convert macro MACvDisableBarkerPreambleMd

 drivers/staging/vt6655/device_main.c | 46 +++++++++++++++++++++++++---
 drivers/staging/vt6655/mac.h         | 34 +-------------------
 2 files changed, 43 insertions(+), 37 deletions(-)

-- 
2.37.1

