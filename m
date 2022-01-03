Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32F482DC2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiACES5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiACESz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:18:55 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB8EC061761;
        Sun,  2 Jan 2022 20:18:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j18so67572977wrd.2;
        Sun, 02 Jan 2022 20:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ADfSrw+I5s6jR3RqKBwu+b6zElbLRLstrGy16nxy4VM=;
        b=cs9GOZlCzVpSuSzd8Mk85CapVOQnAOg2XAsLLTP2WyvW+EmXUtGyvceA/AEuXNfdF/
         2FUhv+O5VVwy64ODNSlKb5j3E7zamcQKKAQ5ICsNw01KHVhXyPJExoH8UTMaMv+s5BGm
         s/ThvJno0jjlGFPGDycQ4VqGr51aMey6u+aLoLo4ufBMV3BsYh/AJ8R6IT2oJHuw4Ngl
         MRAoXmlhggG8p5Czz8eqsgoUyOnuiWOvD+5e50/QVxEI9whuBbTkngXttYCTzlQUvibY
         NtICs4/3g5RdcevT+NZThU9rbZG8yuvKRhfTDjJ3E5x2dtAHX6ju/MTSW7l4gP+WlMCz
         47Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ADfSrw+I5s6jR3RqKBwu+b6zElbLRLstrGy16nxy4VM=;
        b=UayoX5YDmThUErgW45XnPtQEQzn1gmddg+FbXTUtyq8gb5poo3gvb+IHg4PT/oBLQY
         Rqzpo70p9YSxWrMImWABQi8TbSL4XvxiQi7szebQGYyvQOVv26jqLGYgb6GaExUP0DyL
         /FZUE+KsFKfogiCaufMoqmLGrR09eKLCT6vZiqg6EgjkGqi/xz7tqA+9Vos2b6ph6tQM
         K4giXfwRY+iz/UdGKTxMvbj2QBFb1RFaTQDlPxmrMcCJy/Ce0nn/wCJu7cwc+QKECnbk
         TagbQtyH1YBPMJHCMlD1pV9Xrayiopxuq99qqypi+FMieCLEXjEwTR3RVoHMhnfSzfqb
         6mTw==
X-Gm-Message-State: AOAM530CGsaDGdnjCEyV5muVlD3pbuXNWBqv3HPbeKB8Z8HS/cJ/GflH
        +vVt//H9e490gH2Rv1cpIBuv7Ao6MX0=
X-Google-Smtp-Source: ABdhPJwDgz+avi45AVMhgBj74XAammhDE5p2nF1zo0KbDqje49fo2J5061IN2RtUdySm/RYNz36Png==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr37806599wrr.422.1641183533295;
        Sun, 02 Jan 2022 20:18:53 -0800 (PST)
Received: from [192.168.178.40] (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id l2sm34937301wrs.43.2022.01.02.20.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jan 2022 20:18:52 -0800 (PST)
Subject: Re: [PATCH] scripts: kernel-doc: transform documentation into POD
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211209225549.69010-1-tomasz.warniello@gmail.com>
 <87h7b8cfg0.fsf@meer.lwn.net>
From:   =?UTF-8?B?VG9tYXN6IFdhcm5pZcWCxYJv?= <tomasz.warniello@gmail.com>
Message-ID: <0796a780-f5ee-0b6c-e7ef-544ba5f6a429@gmail.com>
Date:   Mon, 3 Jan 2022 05:18:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87h7b8cfg0.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2021 00:12, Jonathan Corbet wrote:
>>  my $kernelversion;
>> @@ -468,7 +306,7 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
>>      } elsif ($cmd eq "Werror") {
>>  	$Werror = 1;
>>      } elsif (($cmd eq "h") || ($cmd eq "help")) {
>> -	usage();
>> +			pod2usage(-exitval => 0, -verbose => 2);
> 
> Why the strange indentation here?  This file is far from pretty, but
> that makes it worse.  (Other places too).

Sometimes beauty requires cooperation. You can help it in your pager.
If it's less, then try `-x 2`, `-x 4`, etc.

I will address the other topics in a new version. To be sent shortly.

Tx, TW
