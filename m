Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72FC5B10AC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiIGXyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGXyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:54:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256DDCEB3F;
        Wed,  7 Sep 2022 16:54:05 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a22so11690293qtw.10;
        Wed, 07 Sep 2022 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UDapgCqCrioyyjd1HYg2i4dYX+eXGdOastwXguzpfCQ=;
        b=TioULE1BzouWQROPIFZtfg3wNszdfL/HSty7GvGw7IhAVcVu6sFjodz/HSOvHz+Upz
         b/aTQXvIWrSBxB6BJpIePmoBvx6uURHcuVUpB1NIAQFT8qzlM5v1ev/R909VnvjH97s9
         XiUqqD9CDEF6Gi0983EZDOPNphWJWhDZ0ZVMX2KJj4e6/2XjDl2QSWWghWFE7bhHnpdY
         GxEZ42VDYECeRM1oPy4aKxjZu84dqNZzZp9y7UyXJw4Doxj5dIQT1sEcz69Eq/ABgIC+
         +ZFTqwW8pmvAIKqKrzH5ASBxBO2qy+pHBKY/ZXt0jzK4QXkPlU+gDKyewA9TtDFw0zYj
         AD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UDapgCqCrioyyjd1HYg2i4dYX+eXGdOastwXguzpfCQ=;
        b=k1tqfViebmLdLC9dXilTJ26nMS+UPMKuKo2iUYmjeLsKgOn3mUPiQCRUSyQYayPnem
         5aysmgZVndABgbrTMf3tV16SXMAUb55sM8ubHBJ/a2fev/qxY/Y3vVhhq4wwpZS6fJ+b
         dMjBQysXXZCPiPWYSmJqVz5jzSWV9eJWyZ7em+HfWU4WFgrEOdFmBQa3KJBvjOZ38PTx
         SYKZDC2ukkNTD+8JCkAQE4PQ6ICKsorYtkQ2oQ2ToOKfOWRGDzaedRbhd4UBAA2BJNRp
         K6xrB+2usHid6mpO/u+Kz3PYsQ+bSgdkeiN/a45FBDoTxx26L4iJWdZ94HSvb2/Stxbu
         Zr7w==
X-Gm-Message-State: ACgBeo39T7UIhFX0axbdsz3+vDTYeFg3pOCHkYJG+qpVm6rgPQxI0re3
        SQjZqmvRn8okcMQC8JXMTN2zgvlHOk4=
X-Google-Smtp-Source: AA6agR63pXwIsoyMhnZfuZhGar6/IWAVYl+yIoMDQefOhI+Zh0Cq6uASRaSZwNWx3XJwOn7FQTd67g==
X-Received: by 2002:a05:622a:1196:b0:342:f7a9:a138 with SMTP id m22-20020a05622a119600b00342f7a9a138mr5720972qtk.344.1662594844305;
        Wed, 07 Sep 2022 16:54:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:e04f:ce6d:5ddb:39bc? ([2600:1700:2442:6db0:e04f:ce6d:5ddb:39bc])
        by smtp.gmail.com with ESMTPSA id d6-20020a05620a240600b006c91ca45b1bsm8344027qkn.55.2022.09.07.16.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 16:54:02 -0700 (PDT)
Message-ID: <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
Date:   Wed, 7 Sep 2022 18:54:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] driver: of: overlay: demote message to warning
Content-Language: en-US
To:     Daniel Walker <danielwa@cisco.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     xe-linux-external@cisco.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220907230709.271889-1-danielwa@cisco.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220907230709.271889-1-danielwa@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 18:07, Daniel Walker wrote:
> This warning message shows by default on the vast majority of overlays
> applied. Despite the text identifying this as a warning it is marked
> with the loglevel for error. At Cisco we filter the loglevels to only
> show error messages. We end up seeing this message but it's not really
> an error.
> 
> For this reason it makes sense to demote the message to the warning
> loglevel.
> 
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>  drivers/of/overlay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index bd8ff4df723d..4ae276ed9a65 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -358,7 +358,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>  	}
>  
>  	if (!of_node_check_flag(target->np, OF_OVERLAY))
> -		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
> +		pr_warn("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>  		       target->np, new_prop->name);
>  
>  	if (ret) {

NACK

This is showing a real problem with the overlay.

-Frank
