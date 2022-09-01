Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387ED5A8B3E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiIACKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiIACJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:09:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C98CE02;
        Wed, 31 Aug 2022 19:09:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so1109099pjc.3;
        Wed, 31 Aug 2022 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uqwVZZsUckaDfIoCaxGsINNSIuzIYhX356j0EWnYVmg=;
        b=Og0Hqbql80oiHkEMZQky7WfTUakS+eJ2Mw25BR9rns0S97A41C0bB+jUrJErx+O8qS
         pRqe8wRYi7S2kaqD7rMA09VN55BqMiQpsA10p/IFhwvm4cquWKzTRQaoTGrjCMXsZfSS
         yrzlHJJ5cBZYhEcYnDvmtOz0tk6Sx/X4+cxZcMPgKGHyCvw31Bw5td28Y+n+uTsAoXdw
         pWfLCIhsDX/YSJLmeY4GaWVbNVoan/ladoBoxew2zgt+lN75unRXw2nuH4ttLVACAGGC
         Si1lGDaXdvg10SCODLqfnY6k7kFeSGgHa6p1CB1N5aJHMs+WPOyQoT9I3/Nkc5RFAJvL
         6qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uqwVZZsUckaDfIoCaxGsINNSIuzIYhX356j0EWnYVmg=;
        b=hUahMb1lSIBqnmtN2RVr9m9908sMcD4LwXjbFvLRU6dQVq3XdUx/mE1TcWatpuLm8g
         wwGEa/2KGLAZ31fdJ7bxe6ZpEgvT7urJCMuwnSvGibkWdhRTfJF3uh5uXtz7cpmLtZl9
         Ho6bQ8EVyOK4oQMJzuERhd3louQZ/zAY6l8HEMTeyQOy58vkLGn7m7NHxOdKyO1nHKUG
         +JKfLX+FS50RKuKBCUoKlG2/HV0HQpK5cKuh4Orjy5z0TQG/Bkik+U6mKcrB1Td9mhnD
         9GS+eBf6ucm1ZNcdY7qEtwmFVH/dM9YqhDqYkrGwCdPIFtcRk+jiGbjS7pHIVTGzMsJ6
         OWgw==
X-Gm-Message-State: ACgBeo15Szl0bkzOKq2P5saC+QA+vtkz3in7AJY1pdQQJ48i2O/CaA5t
        cTkmGZtRIWe0wnjl8UnmKZ8QrhB8xIRueM2zYg4=
X-Google-Smtp-Source: AA6agR7XKvEZ07SfBY6KdR6T/6YVR8JwWIQS0x5y9aOzw1J1TfIxwCvBIFuipc1nC5c+3b/Z8epvK7EC9M2hacfrNdg=
X-Received: by 2002:a17:90b:17ce:b0:1fb:3b43:f6f8 with SMTP id
 me14-20020a17090b17ce00b001fb3b43f6f8mr6389698pjb.76.1661998188976; Wed, 31
 Aug 2022 19:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220901020402.50206-1-joy.zou@nxp.com>
In-Reply-To: <20220901020402.50206-1-joy.zou@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 31 Aug 2022 23:09:37 -0300
Message-ID: <CAOMZO5BEwrmBTqtWoaNRQiG9dxx=T=TAf11f2ce=hBb1_mAjSw@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] ARM: dts: imx: update sdma node name format
To:     Joy Zou <joy.zou@nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joy.

On Wed, Aug 31, 2022 at 11:02 PM Joy Zou <joy.zou@nxp.com> wrote:
>
> change the sdma node name format 'sdma' into 'dma-controller'.

The changes looks good, but the commit log needs to be improved.

Please explain the rationale for changing the name. Something like this:

Node names should be generic, so change the node name from
'sdma' to 'dma-controller'.

Thanks
