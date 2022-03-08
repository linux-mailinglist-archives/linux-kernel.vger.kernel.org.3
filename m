Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065D24D1BE5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244230AbiCHPjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiCHPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:39:42 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED6638C;
        Tue,  8 Mar 2022 07:38:43 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id y12so11466662edt.9;
        Tue, 08 Mar 2022 07:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J7lZq9Kxi6WSzzum4V3PKJxEiGw6D939Fgbe2EfUoA0=;
        b=5leR0NxktoBkeUX6qEiyFah95ugvCvoJdkb76S00FiaYVk9KBFjpkrHGl25IBW2viV
         93w7gmaesL0BruHl+Z+L8+DLisphKOmZvP4Xsnb0P3N9/A+Yt6LBSSrnhQtfaoXOhTTj
         +O6UGHo1/2Rlk3fa5fGT1SEnwwkdJR+CDS5sd7vy4jK6xLzRzNrVw5/uQKXu7bVZGSMT
         +39cj94gxzYVvqwwI+D8/j+TR4k7to5v8TSae2XbKBK/TVvc/7JXwl5Bc+DJ/rcmzxPY
         DeTvPP0I19xyMqxB0nyKqBHF0lDzpJfuACn0CBntnKhQcyf1NDa5vdbmr6uaP09IXchZ
         xI4w==
X-Gm-Message-State: AOAM530W/XjrnynHtNc5iKUmDNp+AswVoM14pezP1IxgQY/Zcw3ySSbG
        o+OkaxtuGpqofmBOZJqo4+U=
X-Google-Smtp-Source: ABdhPJz3qlNB795xg137LA/AATiO/pMSaAcaFED17DreeZL8mtcHTEoJ3n8wlh7NsMix/bUsUS2oeg==
X-Received: by 2002:a05:6402:34cc:b0:416:63d6:1891 with SMTP id w12-20020a05640234cc00b0041663d61891mr6336581edc.308.1646753921720;
        Tue, 08 Mar 2022 07:38:41 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id t3-20020a170906268300b006db02dda82fsm3787473ejc.168.2022.03.08.07.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 07:38:40 -0800 (PST)
Message-ID: <901bc0fb-8963-49c9-e838-dc6dc358a1d0@kernel.org>
Date:   Tue, 8 Mar 2022 16:38:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/4] usb: host: export symbols for xhci hooks usage
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
References: <1646648256-105214-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220307101850epcas2p4ac4158cd821031464cd3aa6eb4e5d2a7@epcas2p4.samsung.com>
 <1646648256-105214-2-git-send-email-dh10.jung@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1646648256-105214-2-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 11:17, Daehwan Jung wrote:
> Export symbols for xhci hooks usage:
> 	xhci_ring_free
> 	- Allow xhci hook to free xhci_ring.
> 

Please do not ignore comments of reviewers. Either you discuss with
them, or you implement. Ignoring is a non-cooperative choice.

Address first comments you received in v1.


Best regards,
Krzysztof
