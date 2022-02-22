Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5D84C03D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiBVV2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbiBVV2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:28:03 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3198B113DA6;
        Tue, 22 Feb 2022 13:27:36 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bg10so46875483ejb.4;
        Tue, 22 Feb 2022 13:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jS5gM1YIuXIK/IIJZRTIoCY8pDveqvlxNRuXyb+ydIc=;
        b=TgCxT6VHp+F40PdbdgBVhu+Hvidulvu8QbEHTIyjOmX6ZjpKQ6YIUrf3iM/bP4V9pH
         2Coq9+cZCJh3Mgo6sc45MjyeUocT/vG03XMgZ1/a7tcjDMcA/noYw1KmQwNzmnLT/hn4
         99Ds/f3cSXBX3cUYOeXpPNKgACR8BAgzJv7x/w1rCPHf/bnZleSwzWQFGsNsYpvMsg/o
         t8YXh0oHEhTcrrP+7z5FBrkEAKdy1jMR9EG8MR30d3FkXFIRc1jSgOdgEqIkZEajhBgT
         l4Zool/DpzLYt/oB37JlD8EdlMmRkOxfA+HAy8en/K1VU6IAkug9SDl5yQ8erTeGQfFz
         XeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jS5gM1YIuXIK/IIJZRTIoCY8pDveqvlxNRuXyb+ydIc=;
        b=1RTXsPjXl+LnKtD49bznL+387YTKBsUird+KRa4tAZebeD+wY7bcb9DX3lrJ5Bv583
         ieJVd1onXs5NnH8qI+vaxDjSU+PVasqyK+Y+hoQt6und0tWZVGegG3HqUmEhbfna36J1
         nBJ5oPTEmxqCL4i1h3wTh5ObNPu5yeZFwXZ0zB8oA6FtnCUxdZiLWqOYX5pjRiL2nx18
         d7T9lhHKAIzn8BKLcwMzkvMn5aKYaiXl+yIyPRntEQkoOEzviq9RvYiZEs0C2/Pf+lnm
         PEbARPMoVwNglg9DQbAYjYXSJ3PTcCpza2x03G1L3BtoxHBnex9RGlELbLPkKPsIRSqT
         OmTA==
X-Gm-Message-State: AOAM53136wKjCmz21WYdprA79fqNHrPTft1zsRmm+7U9rD34IoI1SteT
        ldYKCTPVqa4aSwU6hp+NTLEEDvUdziw=
X-Google-Smtp-Source: ABdhPJwHs27QqqK3E5MP2/I3MYUuYbNhU7XOLH2vAFSeCe4bO0TizjNhk3HNQP4SxqFiHzQB0MzSew==
X-Received: by 2002:a17:906:2a97:b0:6b4:143f:37c6 with SMTP id l23-20020a1709062a9700b006b4143f37c6mr21415480eje.133.1645565254722;
        Tue, 22 Feb 2022 13:27:34 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id i6sm6709778eja.132.2022.02.22.13.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 13:27:34 -0800 (PST)
Date:   Tue, 22 Feb 2022 22:27:29 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] scripts: kernel-doc: Add the basic POD
 sections
Message-ID: <20220222222729.404611b7@fuji.fritz.box>
In-Reply-To: <7852b505-a65a-6cdd-29a8-3bc966dfc750@infradead.org>
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
        <20220218181628.1411551-2-tomasz.warniello@gmail.com>
        <7852b505-a65a-6cdd-29a8-3bc966dfc750@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022 22:10:22 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Nit:
> $ ./scripts/kernel-doc -h
> says:
>     Run `kernel-doc -h` for details.

Hi Randy,

The -h printout is complete and the synopsis section is only a doc section.
To me this is a very minor concern. I wouldn't even bother to correct this.
The phrasing is not very intelligent in the -h context, but I wouldn't
contextualise this sentence for simplicity. It might be toned down to fit
nicer in multiple contexts, but in the end someone running the -h mode
doesn't need this information at all. And the same applies to this parameter's
description in the "Other parameters" subsection. A user running -h will
know that. What counts to me is syntactical coherence and again - simplicity.

Thanks,

Tomasz

