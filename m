Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8EE53DCA7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbiFEQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiFEQDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:03:52 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6792326E1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:03:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y29so13415302ljd.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8j4Ucv+Lybc/XuEfT3hO1ywcwWTOvwSEkCH8CD9yV8c=;
        b=mYTiV40uBqdpYeGZKsKyrRnVb0WWonjejPdNzEu6MR8BMJWPVFBqMRVrE0r5NCAazP
         0OHic3xL/LGD94CxLTag35+jET0evL6Fk/nhDSzT8oMxizbV4r4Dr7Zi1GM6TeJpW6tM
         1VsjfxBG8Hws27jN8l+pxzBxxjdYsIjM7azlm8uyRwmNdh6Puh50p3P+GD/t0D/NDHSv
         1l9O5gt8jWQGMu1T5mUkte0cVzLlLdYKERRTPwuRTktqEZ+wjNGDzp6zk/7lifYm4hby
         hXaRMps4kgfZ1aAWYYzkDSKVucEa7S9ieTufAoU1A1CB7gTXpYVYhPaQ9YqZWzQZ6Ykq
         QUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8j4Ucv+Lybc/XuEfT3hO1ywcwWTOvwSEkCH8CD9yV8c=;
        b=wKwDk5NGiMFuPnHxdlOKo2+qmlT8UwPrIL2QIrae51E7ClKwGc6ilwCpZEPZCnIquu
         WcveR5y7ygktggZBbNTzv6FtwIgQ3mPgdGgBs4jKp0UctSjqNsfm+0rTIh3gmxK162a3
         IAF9rfbcOXhOoOwCwx1wPAltUKHUh+pZ1fht9gVNbx2E3wh25ZZ483vP2fVe37lcF+P+
         OdF7maMMAOedoXtVrRsTZWGTZxFGj6TqkXv3F9swLdQ17etnnn1Tjo/TXqIbfQQ6N1WH
         fvYxi44udfr7MOspLlE4vCZoz3mDOgCH9gVXSTmuAxLeHiPN98+aT2PNcQvMn4msnz8S
         qzLw==
X-Gm-Message-State: AOAM530VOrjDlhp9wgcPnbV4r43F4yzEXXuG+6GWQp1eUYlgm26QpfOR
        4MI2vAa3O52sJumLm5byvjA=
X-Google-Smtp-Source: ABdhPJyEW/KXIsbUdrVk+gnZ+9xPYcq6cr0Kd2Wb+8uyCr5FmlHp3AKxiBHntAVGiTVx6XtMCISsMA==
X-Received: by 2002:a2e:700c:0:b0:255:7dab:aad with SMTP id l12-20020a2e700c000000b002557dab0aadmr7277712ljc.492.1654445025834;
        Sun, 05 Jun 2022 09:03:45 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id x4-20020ac25dc4000000b0047255d210fcsm2529796lfq.43.2022.06.05.09.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 09:03:45 -0700 (PDT)
Message-ID: <e1f68045-a9ab-5fc8-17eb-9cc4543ef55f@gmail.com>
Date:   Sun, 5 Jun 2022 19:03:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 00/11] staging: r8188eu: continue the cleanup of
 issue_action_BA
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220602193726.280922-1-martin@kaiser.cx>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220602193726.280922-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 6/2/22 22:37, Martin Kaiser wrote:
> Simplify the code to send the addba response and the delba message. Use
> ieee80211 helpers if possible.
> 
> This series should be applied after the "start cleaning up
> issue_action_BA" series.
> 
> Martin Kaiser (11):
>    staging: r8188eu: use mgmt to set resp dialog token
>    staging: r8188eu: use mgmt to set the addba resp status
>    staging: r8188eu: use mgmt to set the addba resp timeout
>    staging: r8188eu: use ieee80211 to set addba resp capabilities
>    staging: r8188eu: calculate the addba response length
>    staging: r8188eu: use mgmt to set the delba reason code
>    staging: r8188eu: use mgmt to set delba params
>    staging: r8188eu: clarify the contents of the delba params
>    staging: r8188eu: calculate the delba length
>    staging: r8188eu: remove the pframe variable
>    staging: r8188eu: use u8, u16 in issue_action_BA prototype
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 51 +++++++------------
>   .../staging/r8188eu/include/rtw_mlme_ext.h    |  3 +-
>   2 files changed, 18 insertions(+), 36 deletions(-)
> 

Looks fine, thanks!

Tested-by: Pavel Skripkin <paskripkin@gmail.com>




With regards,
Pavel Skripkin
