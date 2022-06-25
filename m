Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B05455AB46
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiFYPYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 11:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFYPYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 11:24:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE70014D18;
        Sat, 25 Jun 2022 08:24:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so3072636wmb.5;
        Sat, 25 Jun 2022 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zHkSHo7U+hVtDYgv/w+fcKWurq5TOmqK+1yqpjV2Ulk=;
        b=VRIz17imvjeXJ8aAIi2w84nhPRIp9nHQUkHbQfo9t/J+7W1pbg04cLiwjYUT7PEyYX
         23UhvwAW6+BfvcC3CSO6cCwPeQid1jQKbGONe3XjSTILKP2oAKNglWTU+ry0Xs3iKejI
         tAXBhKEQGYtf/PViZDs+AwM0NBP/g6qvVh8qkfo3i77+rq/o8zMC+1DnR5rU7XuhqlSt
         qoywCVMGlEQ9szJ+J2QIdYyAjM3eiZqthebhwUwyIfPz/5QD2epwBvkr2mIt2JsqJ/WS
         QnpS4i8j8fZPpghkbFgOFipqnVqbdtgyh0YQF7CCV8LcdNle+2nbSN4lJ1668hHNZpQZ
         oXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zHkSHo7U+hVtDYgv/w+fcKWurq5TOmqK+1yqpjV2Ulk=;
        b=QLnSVAftbBf85jMLusOrnLXTfEKCLLgMJmJ5NS6hN47VK9tw5H6Ii2E78tb9Loa89h
         rQ+2/U27ggwVTsseNKQaxAdqsXI1A8nG1YMNVqpCDO4rKUzsx0wUoOEho99avtRF9cq2
         BgIswfVgtkUbKBTGVMVP02pIVbaIVZ2CfDnlbYuy9djetLC20hx2EUDTvEaq6OMxl8r/
         sjitX0uL1O6iIv1CZOsJSWmPfVQ+dsc/futjqWqHJ/a/i9blv1z4azH3LU48hXfqw6rH
         IX8jqk9DVP0EwwLtfHHTotQTOapWIE0O8vJJ3IwtHIov6iodU2KzXaPVGkwfs5zNaTsL
         i/ZA==
X-Gm-Message-State: AJIora+m479ZgOcCIYPZxVCLkUXQHhuOu4WLm5T6nV/EhEt4anJ4LlIl
        f3lfMp4Qrord4jXq1CSWloWQft5wQCs=
X-Google-Smtp-Source: AGRyM1v4/j4Oi/3Txy1BvrHwMsYM4Oq7vUJQOrjIxaoODRjJ18kk0oUtQ2nP3zU9uST7+bk/LSaOJw==
X-Received: by 2002:a05:600c:385:b0:3a0:2319:9a20 with SMTP id w5-20020a05600c038500b003a023199a20mr4928221wmd.18.1656170681202;
        Sat, 25 Jun 2022 08:24:41 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id q26-20020a056000137a00b0021b8a3528bcsm5579735wrz.56.2022.06.25.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 08:24:40 -0700 (PDT)
Date:   Sat, 25 Jun 2022 17:24:38 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Nikolai Kondrashov <spbnick@gmail.com>
Cc:     Stefan Berzl <stefanberzl@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: Add support for the xp-pen deco mini7 tablet
Message-ID: <20220625152438.GA4820@elementary>
References: <85312611-797f-2dd2-f864-f7c13cb889f9@gmail.com>
 <nycvar.YFH.7.76.2206091058530.14340@cbobk.fhfr.pm>
 <c856a79c-1d42-6af5-0ff3-589688701fc0@gmail.com>
 <20220623175116.GA4757@elementary>
 <62d69463-35c0-683d-f03e-c668ea82136d@gmail.com>
 <39fb9b40-061d-284b-e36e-c944a2d209c0@gmail.com>
 <6ebb8b6c-901e-f7b1-f29e-2182fd183b8d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ebb8b6c-901e-f7b1-f29e-2182fd183b8d@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nickolai,

Nikolai Kondrashov wrote:
> I think it's OK to just ignore the first packet for these devices, even if the
> ACK packet is not sent for some of them. Even with the report rate of 20 years
> ago nobody would've noticed if you dropped one packet.

A bit more of context about this initial packet:

These XP-PEN devices need to receive a packet of data to be fully functional.
The driver sends it:

	02 b0 04 00 00 00 00 00 00 00

And in response to the activation packet, the tablet sends an ACK:

	02 b1 04 00 00 00 00 00 00 00

In my case the packet is ignored but on Stepfan's tablet, this packet sends to
mouse pointer to the 0,0 coordinates.

Looking at the data he added to his last email, his tablet ACK has 2 extra
bytes, making it match the size of a pen report.
Because the ACK packet starts with 02 it looks like it is  interpreted as a pen
report with all values set to 0, including X and Y.

We are not worried about a packet being dropped, we would like to filter the
ACK so it does not get handled as a pen report. This should allow to
avoid sending the pointer to 0,0 on device connection.

It is not a super anoying bug, but it'll be nice if we could avoid it.

Best wishes,
Jose
