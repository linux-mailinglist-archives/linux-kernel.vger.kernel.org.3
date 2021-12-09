Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1946F6FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhLIWlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:41:40 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:38518 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhLIWlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:41:39 -0500
Received: by mail-pg1-f169.google.com with SMTP id s137so6372299pgs.5;
        Thu, 09 Dec 2021 14:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+CFe2awBT3gEDhAPefbc8+v7i0Z/5e7DrF49U0Vwz8=;
        b=1nFC8u8raEjKk0oPRboyTFTSs1mB3pKuErDMAUK8kMOkBHhbWGl2n5USU5bBpwoOWh
         7PejUxjMc6zi5iEz+zYDWvDKAK/O+/agn/bu5SE5eizvH09Z+fH3o4MciRwYk4w9zGqh
         iA9vc3ZCDqfsUwxs97U9A2F1FFm7K0Q6vIuTlkOKQGuu5fEceHeBvl0bdFTAgBMrscT5
         XaUeLv0HyK4wqPzQzHsYl1YwXWo9tuC7mC7pTe/KpjrNCAtTSWojsbXJQ8xsdOjqr7cw
         f77y6wA3xWRM4/BqXhtNgM2qzm8FGFXaOBS+D3d97AYx1e9jF0sWWTYg5AbitdnwMsWI
         CtYQ==
X-Gm-Message-State: AOAM532NGtXQY+3agZhGatFoRBxOBM6aElnGiNGI4QP6eIjH7GbwKWS5
        +fCNz+zUbZusFKrUeReAOAk3JHaiPeY=
X-Google-Smtp-Source: ABdhPJytGEjLrNYi/kW04zufjT96p/uTD9pYevJ/2vCx1OWhTYXvO4D8jL09b6yXcg0fKOpx0DJG1Q==
X-Received: by 2002:a05:6a00:26e3:b0:49f:c0ca:850e with SMTP id p35-20020a056a0026e300b0049fc0ca850emr14439430pfw.4.1639089485540;
        Thu, 09 Dec 2021 14:38:05 -0800 (PST)
Received: from ?IPv6:2620:0:1000:2514:4f5b:f494:7264:b4d4? ([2620:0:1000:2514:4f5b:f494:7264:b4d4])
        by smtp.gmail.com with ESMTPSA id e35sm546735pgm.92.2021.12.09.14.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 14:38:04 -0800 (PST)
Subject: Re: [PATCH v3 2/3] block: don't delete queue kobject before its
 children
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-3-ebiggers@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2a029611-10da-9114-b66b-345a68a5bd36@acm.org>
Date:   Thu, 9 Dec 2021 14:38:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208013534.136590-3-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 5:35 PM, Eric Biggers wrote:
> +	/* Now that all child objects were deleted, the queue can be deleted. */

Shouldn't the present tense be used above (were -> are)? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
