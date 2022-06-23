Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735C2558859
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiFWTIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiFWS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:57:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F5B4316;
        Thu, 23 Jun 2022 11:01:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p6-20020a05600c1d8600b003a035657950so165832wms.4;
        Thu, 23 Jun 2022 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QYPcW1hEJAKXQTfy6ssNBNN9iygcjxjI39Ht44KpS84=;
        b=SMx7rDnKYxQ/yE41yzcDYth0Dxqlu1QtP2qcFwcdkcex3AS/qnkkhlm8aGLy8Xe7PE
         Hefyqx5E7QCIFxfCgMUatHuSeZ7c5mqUv++NWDsEBdcgHL5IVYTdmxTEQXJLgLeBWXDs
         180AzNiH7f1Fbs7tT5aJuWW8cwiV1t91jGBn9W7nD1e17F+V4lV2qAUUERVau8cWjGvQ
         qWsj/VKZapAO5Up3BTd7zd7/q/6KWcjUbdVT7XO4E+t7XElGn7U0WOhYHsV25NH2n+AE
         ax672YvSn+6bFakOjmcUZU+j4MOePY8qLV+g2vccyayJeSx1DKI0nwa0iSBRrCb/BHWo
         CSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QYPcW1hEJAKXQTfy6ssNBNN9iygcjxjI39Ht44KpS84=;
        b=pcaYdqJNIrG9VPSMvI3wsFP9lwVfSACqRB7hT+L4GsuLK60d4+AnbbYEjrpKzE+Cmo
         OpQYKRG9eJz1cCVMn3y7ebYYKfshDcNR8KeawrlT4GBLZOJjcRBM8XYm0ZjqdJd31yWG
         5A72q8EQrSnTo+Z5kjt8CMBd/tb2aWv2yI+X4TveAHQc+y2R6YxjD+BES0x7pZZ5mndj
         Bvzzpmqand6wuj+FgFB8VQA+bFwzE7yuilXV1Ko3CmKjcRadPYOgK2RAU6BxG5m3feWV
         JptlKRrSivzjg8YwBVKqraoDmkE1BzrOlVJfn9vslNQidcncygHnEhsMS8B49JxVUhmV
         ASDA==
X-Gm-Message-State: AJIora+NtKaCg6gv1utq31uwg5uPw5m7BndSfJ7sd2z3cYIkCo8mhvqw
        xnbnyrVUq2wrb/fOc026qzY=
X-Google-Smtp-Source: AGRyM1seeWn1XAx+b2vbfPrOYxt9H4MzoYh20GcLYgTRvrxDQVLVBf4IxxreeZEKG6d3YeVset+DEg==
X-Received: by 2002:a7b:c4ce:0:b0:3a0:2ac4:3233 with SMTP id g14-20020a7bc4ce000000b003a02ac43233mr5568067wmk.92.1656007304136;
        Thu, 23 Jun 2022 11:01:44 -0700 (PDT)
Received: from [192.168.0.118] (88-113-28-27.elisa-laajakaista.fi. [88.113.28.27])
        by smtp.gmail.com with ESMTPSA id p17-20020a7bcc91000000b0039c4ec6fdacsm6275wma.40.2022.06.23.11.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 11:01:43 -0700 (PDT)
Message-ID: <62d69463-35c0-683d-f03e-c668ea82136d@gmail.com>
Date:   Thu, 23 Jun 2022 21:01:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] hid: Add support for the xp-pen deco mini7 tablet
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Stefan Berzl <stefanberzl@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <85312611-797f-2dd2-f864-f7c13cb889f9@gmail.com>
 <nycvar.YFH.7.76.2206091058530.14340@cbobk.fhfr.pm>
 <c856a79c-1d42-6af5-0ff3-589688701fc0@gmail.com>
 <20220623175116.GA4757@elementary>
From:   Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <20220623175116.GA4757@elementary>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 20:51, José Expósito wrote:
>> I would of course fix this, but I don't really know what's the preferred
>> way. One can obviously simply set up an urb to catch this, but it would
>> have to be a special corner case for the mini 7, as José assures me that
>> none of his tablets display similar behavior. Is this acceptable?
> 
> My tablets also send an ACK packet, but in my case it does not have any
> visible effects. Maybe it is related to the DE environment used. I
> tested it on elementary OS (Ubuntu) and Fedora 36, in both cases the
> ACK is ignored... But catching it is fine, we can include the code you
> suggest.
> 
>> José already had a look at some firmware device descriptor string that
>> reports the number of buttons and what not, but as far as I know, it
>> doesn't say anything about ack packets (right José? Does it say
>> anything about touch strips or similar?).
> 
> In the devices I tested, the ACK packet is always present, so it should
> be fine to catch it. I'll test your patch in all the devices I own to
> be safe.

I think it's OK to just ignore the first packet for these devices, even if the 
ACK packet is not sent for some of them. Even with the report rate of 20 years 
ago nobody would've noticed if you dropped one packet.

Nick
