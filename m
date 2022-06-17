Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF654FF8D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiFQVz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiFQVzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:55:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5CE3DA6B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:55:21 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s135so5074159pgs.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0pY03W2fp5T2BCJ96x5wzg51Q4zsPAVWomKjp9zohkw=;
        b=BUeTdxCnqu1oCpxvdqEYFNWLorOdeohZfNL7qnTA00F6Ezx0Rt0GPiReyXSSVQKr3c
         dlBqMrhVUsXqcWDyqQR8gpWvDOHHngK5mlNPUBY9I7jWSZF6DFMWVTqkK/yHXbU2M6D8
         FDiiveiVjWd/GBTu+yBD3GQLdSRs7ByrYRGjLVjoaqDYNByz0yyKKWpghpcJGlaSHu5v
         wlBQFQ4Ii9hRpWrLNkLqizCI9AtCH7i82yMuy8eXPSNmtraOqzutVP6hjIDqdbMI5aI8
         UeBoj/0ZAUMhMDE9oEOWOmAmjJmX76xirQcu3obVECSGn56UmocfYh8hgOSv/R/XHMe8
         XYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0pY03W2fp5T2BCJ96x5wzg51Q4zsPAVWomKjp9zohkw=;
        b=0W75w+B8MwOI5oeyVfb/ves5lzgWTVa339v4sLkJxGq/WZ7aAWUy+n6JeHIN+04/p7
         VLmQlHE/QTGa1IwRN0m+UHmKyqDZl/UWm4yEAImDbsz8YnFEdEuzkFWBimkHapZThk6a
         BPecFjtqw5nxi8NkZYnkJi0FGEg6wUzQrzcJ0AnaNjA20XXBdRBL8CPdiHpu0m7gvulm
         Dn+2U1aiSwQ7gNjkVRS/JlyBfF7rqWlD9G+hF7GgUe5hs+QV1xF/jUy/G0a2B0yJwzFB
         qwiSOtlBGUKPSMeCz69W9w+YnV4FdmMjn7gOh44sbxY2uDR9tsWhNZZHVbHlcZU9HElv
         Tziw==
X-Gm-Message-State: AJIora8b915HRvHwptp5Uv2GqrD2MKY0VHQPkCNwLVUT0anm3wVe05F0
        kEev52i7TpHmxR+s56kY3Tkz5AC2vOk=
X-Google-Smtp-Source: AGRyM1tqkJqvhR0Ecj1IBeTnLz7O6cowv2HLffiO3GAw8TGX2lfBEyjnEd/pWYPI1dJOPFVZRaFihA==
X-Received: by 2002:a05:6a00:15c9:b0:51c:178:ac7e with SMTP id o9-20020a056a0015c900b0051c0178ac7emr11988517pfu.64.1655502920798;
        Fri, 17 Jun 2022 14:55:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170903249000b00163f1831ddfsm4038238plw.40.2022.06.17.14.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 14:55:20 -0700 (PDT)
Message-ID: <1dea79bc-6eff-9558-8bcd-a5c36f2978e1@gmail.com>
Date:   Fri, 17 Jun 2022 14:55:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drivers: soc: bcm: brcmstb: Add missing of_node_put() in
 biuctrl.c
Content-Language: en-US
To:     Liang He <windhl@126.com>, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220615140231.3968187-1-windhl@126.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220615140231.3968187-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 07:02, Liang He wrote:
> In brcmstb_biuctrl_init(), of_find_compatible_node() will return a
> node pointer with refcount incremented. We should use of_node_put()
> in each fail path or when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>

Applied, thanks!
-- 
Florian
