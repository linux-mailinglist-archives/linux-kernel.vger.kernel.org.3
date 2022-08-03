Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743A958921F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbiHCSRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbiHCSPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:15:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494B35F92
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:15:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id m8so22453441edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8igigbShakN12Ob89koTKQ1lWm3g1WOZxClAYVXZ2Fk=;
        b=SbtAmqi938JOHKWgCPk6zuwlfb+q+tUSWi87LFyIFgUCJQMsnqFHQCSznB9s6UjIkz
         NOQogF38C0tHsm9fO+o3nVfhGJHPhgJMtzxQsJkdrItf9WoghPYt1KzKwg7Lov73tm6O
         RY+/aNWx+Iva3RoZFgIA5v2ae2/5nNp8W9HEwp8OKS7+gQjJySa16FmMlFv3VN0dwYTc
         6HTGJI1pLd7X7RibAAWiVpvPD6RGLTZZ4+RRFFlbVUsbkZLUfHDhco0FRidVFRRm36Hh
         gvYJGkPGRdd/jvbmtMSoW5tIsDDeeXynMqOvksL8ScvsdTyrCDGGd39QtkXgukTLIJ65
         sgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8igigbShakN12Ob89koTKQ1lWm3g1WOZxClAYVXZ2Fk=;
        b=nsqPHKDocsaFNWn6QfpRyWT3xq4Ufme5Atze3y9QC51IsYtCVUDbwwkMY60RcMZ0me
         E3eR/PtLaSBFDKmdBpbnZhOvcGwcOBTsIcQTvbGxtcrKmqPztg+0TFTL6/sIUAwLAzhW
         E4hdrYGRPeS+dtU/d4OFMSiDr8+wSdvaWW67wVYygJWxOcF5kUu/j9Uyja3NY18NTiSx
         BqjSc5Dujch739u3x2iWyRpyrKG/EF1vAjc8mDVmJDnAr0zj2Y/Fu/c/CWponIAK0ZB3
         AyDT82AeQsJGrUN6jqSuY+ywXGty/X59HLUgormEY9kWFUmAPPH6423m6a+SrPp1+7ar
         7I7g==
X-Gm-Message-State: ACgBeo0PeO4VFgJl/1QfaexUGuRJwnf0gXIlem6MH0FlaP/O59qobWM1
        I0+NaFBqPFdZD9k4XI8lajsINybIBzGwA2UP0/78bQ==
X-Google-Smtp-Source: AA6agR4LLSRCPJNXUpL20SwIpVa0RnAlB2n3f0UmRD66Z+BHaGYrEamCp/s50h/HH62aEW1WtZ83oN0wyaoTgTAR/Qc=
X-Received: by 2002:a05:6402:2398:b0:43d:fd2c:b0a2 with SMTP id
 j24-20020a056402239800b0043dfd2cb0a2mr4481522eda.172.1659550532854; Wed, 03
 Aug 2022 11:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220801144952.141-1-mario.limonciello@amd.com>
In-Reply-To: <20220801144952.141-1-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Aug 2022 20:15:21 +0200
Message-ID: <CACRpkdaHfD=aSUzbY_H2dYJLSWPiY4tXve2EnAc0mBNChpToBA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Fix an unused variable
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        kernel test robot <lkp@intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 4:49 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> `char *output_enable` is no longer used once switching to unicode
> output.
>
> Fixes: e8129a076a50 ("pinctrl: amd: Use unicode for debugfs output")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Patch applied!

Yours,
Linus Walleij
