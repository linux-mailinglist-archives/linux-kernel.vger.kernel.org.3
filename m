Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D1A496957
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 03:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiAVCCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 21:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiAVCCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 21:02:43 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA5AC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 18:02:43 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id d10so4799444eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 18:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PdGWo0gh9u48OYFHB0HQIJEGC6vGR2CtSKThz0uROfk=;
        b=fmm9XSjejTE/qSDJGPuZRA1VGxU3UcBd9jbb6YUr9m2ILTdLvFvwQ9wcHFcp3jMEna
         1nWSNJVDL9QcVEcG3F4Yk3KuKtJXjABanNLV5nWHgmlnPUkeyro4p/okV9sZALk82YiZ
         y0/wtNL4nSXWPiFD5ueEK0VIiFEPNXbPiaE+jvfyLEqhwkyzOI4Wg9u50oe7z8iC5KBD
         w7t/kqHcYIORWqiUWlfmNbUdu+aPPYenZPGu6caJ4KscBt0gHfn7Wc04ge6yXRYzgieO
         fA7OuLQvZ/4L5RylFAJRBzU8pLSP9flcvoAQpKKMXjDtZ56ARJBa+gtisxf/Umqho9UN
         pggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdGWo0gh9u48OYFHB0HQIJEGC6vGR2CtSKThz0uROfk=;
        b=YwcyT2zoG54/pwxSUZaCIaul/7SaHjuNMn5VLheEQn/csQRyKq0uKJQd8cMsHNVliZ
         glAfJZn/FU7SBwqNi17aLODwaLXs756DfeoQO6xFm+SoiH21O+Q2gUeRo4xpIPvaUSn9
         +aJgucCLk2CfOdjRygj+cZL4kWGK2VusIpN9+MNvEeltcO3uSbE40yX1/Q9Rwk2amZUM
         yy7nhI6Rbc/rMGF0A/i9p6MPpPvc7JCJYHSwGBJhXqksbQyQVAcNEISFOULZ1U2UNcC3
         a+Cf68C5xD1+2naM2if68mQxy5q41NKgx6MwaoI19P4qlP4nmmsMspkCRvSKeptVbFEu
         +vyg==
X-Gm-Message-State: AOAM533gWiEWvX5ckF1DVzdt3Vc+2ZotTDsAT2aQm74lUqyx179AeA8X
        cD4ozOX1Hw9UMDWHSNcjgCLktRvpVWwaSBJqOBo=
X-Google-Smtp-Source: ABdhPJzjL1/PJqma30sKQY5UHGLJQhbx9S+QWmBbp6EUPdiAp8cxX6B0xo1JFWCEGHJVZeZecOqPMW+8bEFkSrOLjHI=
X-Received: by 2002:a17:907:2d11:: with SMTP id gs17mr5423661ejc.198.1642816961340;
 Fri, 21 Jan 2022 18:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20220121210258.1152803-1-helgaas@kernel.org>
In-Reply-To: <20220121210258.1152803-1-helgaas@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 21 Jan 2022 18:02:29 -0800
Message-ID: <CAMo8BfKy1b+8m3vvKjr_utb48fbXaXUUu7qfEXzmPnKQO5fVuA@mail.gmail.com>
Subject: Re: [PATCH v1] xtensa: Remove unused early_read_config_byte() et al declarations
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, linux-pci@linux-xtensa.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 1:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> early_read_config_byte() and similar are declared but never defined.
> Remove the unused declarations.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/xtensa/include/asm/pci-bridge.h | 9 ---------
>  1 file changed, 9 deletions(-)

Applied to my xtensa tree.

-- 
Thanks.
-- Max
