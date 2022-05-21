Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0618F52FF14
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 21:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbiEUTsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 15:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiEUTs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 15:48:28 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E8043495;
        Sat, 21 May 2022 12:48:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id bh5so9912398plb.6;
        Sat, 21 May 2022 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vkIYcg4ozxdFwZbcXK1giZmlOpTfDyt1g06l/yyS/pY=;
        b=NzMYvhfny8RP+mFaSib1CJUTh3Z6TCgjhd0BYr9XVcIGsu+Bijgu02yfjG8wohLXYF
         fbkq4ytDDiZ13v4kfF/P4MC/pdSb3kJcWXHCnMll1uHuG7TEsZii391nV2UHfWHxPJDU
         LeDiYO12MGHHmnEzVcOZH2Na8emUylVesiZFlCWMBNsqZnJwXDr6UmvzE/62+O/Rt6jq
         SJAWoJqfsKG41w+IJDoN0hPCRDEAbJCGQjB4iZSe7P/tx3/7AQiAIimEvyve0JAz2pCB
         EtXvgAR9vLqp7vFu5xo2RrvYFYNmNPAqzFWNfXA9E8Uqygu+pLWPDi74kX3Y/RF+pI1Y
         TCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vkIYcg4ozxdFwZbcXK1giZmlOpTfDyt1g06l/yyS/pY=;
        b=0NjA2fvVsZOsOXSDbaMef9teJAS6xszlXD/SB9A5TDQWguSWCbx8/fe3/0Agwm5PQK
         A6ZgarX0IXZ7cOEKimtrP2gXmpxFc72ZQYRxtCXfcE8pZywXRh9X95SpV98S1Gx/ne33
         2ik2wQhCAdMJocbjNUJin4vRILrPwUiS9uvEmIPiDn7chxu3IOy9rVOtJGAd1WBl1tGI
         C7l8KVPvfX/RCc7pYpnm7o12Qrgy2N6Tnnw0jZUWTw0Ek9UaWK5IcozaxyLm37yXFVTp
         ZZWFgVxePNzNDRdltpovXI5kSung9YZx0zPL5MdrWne+G72sCohVO2u/nuVQXIS6R98o
         KxJQ==
X-Gm-Message-State: AOAM531457r6GkePmminJNrgeTsAhhLPXjC+wfKmrKf8OOZw5Ek9TG4b
        LeSM/SnI1JncD27hscSt0lKnbiK18Ts=
X-Google-Smtp-Source: ABdhPJzVENJmNZxK84Hl8TGU5q3vZwoflsC3VwCpf3tUbAARCnhiBrvuUNs1IZ/LKIXBNSL2pvaD2A==
X-Received: by 2002:a17:902:a9ca:b0:15e:f017:91b5 with SMTP id b10-20020a170902a9ca00b0015ef01791b5mr16117331plr.27.1653162506852;
        Sat, 21 May 2022 12:48:26 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:cb52:1dc9:39a:7637])
        by smtp.gmail.com with ESMTPSA id c2-20020a62f842000000b0051800111b2fsm4100840pfm.216.2022.05.21.12.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 12:48:25 -0700 (PDT)
Date:   Sat, 21 May 2022 12:48:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: fix typo in comment
Message-ID: <YolCB016iJKR680m@google.com>
References: <20220521111145.81697-27-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-27-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 01:10:37PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 

Applied, thank you.

-- 
Dmitry
