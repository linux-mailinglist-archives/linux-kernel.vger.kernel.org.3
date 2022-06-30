Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BAB56256E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbiF3Vie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbiF3Vib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:38:31 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768D31F2C4;
        Thu, 30 Jun 2022 14:38:30 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id p14so256868ile.1;
        Thu, 30 Jun 2022 14:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pLjHwdt8TH9Omgx/eV4DUFvAnOF4nqWCnxHdlR/dkE4=;
        b=zWOo4uuxCPlFHFmAqTKuwB25z0izyNZYfwBBppCYXpMwykgNTQX1YjO/4BUiusbSgh
         yQhDyWHW+CPoDF6yMBm8nzK01y0JFPRcdbswd83Ph+9AdNOD1Vf4i3xHkhaect0ipcLG
         drD+unPNLBn2Snou2Xvh9iSjc5sL+++tg0kFQFkmWzM4ibLjfV5zNph3FmiG7BzPtcRj
         RrUe36XQcoTaSyzFW1zDyEAQ6IkQAvKKKguOEWI4yt3P25mcNhCxKUcNiE8140m49mvH
         cP9KlOZ1Zf7PUmBKD5fhBKm/+d0jc7NJm3SNUg6LKd7VDNdjG8LgZXJZSyL3o0mJsCY3
         rwww==
X-Gm-Message-State: AJIora9Nuzb4TMJ/MTumKcbVRLZtb4UYWMb9SRYouuOaKbjh30hZilBU
        e8qj8rBCd+8/GiYSHNohMA==
X-Google-Smtp-Source: AGRyM1ub4VqIUMbN7Saxmn/utQJsJdllO+aKH4aeiaHcd+oT4ZHt2eOVlnAJNDvVcaIqYPweko7aDA==
X-Received: by 2002:a05:6e02:18c5:b0:2da:e18e:c876 with SMTP id s5-20020a056e0218c500b002dae18ec876mr1248065ilu.186.1656625109720;
        Thu, 30 Jun 2022 14:38:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e17-20020a6b5011000000b00675594df2d3sm4166809iob.17.2022.06.30.14.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:38:29 -0700 (PDT)
Received: (nullmailer pid 3353197 invoked by uid 1000);
        Thu, 30 Jun 2022 21:38:27 -0000
Date:   Thu, 30 Jun 2022 15:38:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] docs: dt: writing-bindings: Update URL to DT schemas
Message-ID: <20220630213827.GA3353112-robh@kernel.org>
References: <20220627223950.35748-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627223950.35748-1-paul@crapouillou.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 23:39:50 +0100, Paul Cercueil wrote:
> The previous URL was giving a 404 error.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/writing-bindings.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
