Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1783D53DB0E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbiFEJkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245219AbiFEJkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:40:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C274D637;
        Sun,  5 Jun 2022 02:40:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s12so10055213plp.0;
        Sun, 05 Jun 2022 02:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pA78VroF9WPZrSnfSVpCOb6xs8kbWqUSkVd+dTFpkE8=;
        b=AX8tCS/bv0ghkCoUwzqdtUczLZhpSL1RZROKTaYjn15yKnmpxKI83KvB4PR2dIGqrf
         UymfNMy3kQXC6qvhS0X+yWig1TkHKm8AEelDuVP10LwMdgN3HR+GUuUOefzKj+jU2cOm
         W07hR1cZ8YHTs+U+Ki/lxf0YHcNMEPv5zG5WunT5yW7tBlU5BYf2f9ecLt/6umys0QnT
         t39wzplIBSbE/l/dTkGpIEUykyZ6n2Ev+lqOF8SVKPJRzV6fA3vJQysxEXA8EuVZRrR2
         MBDRl+kJwTgPqtY1FdRkyVFaodGF6DyifNPVejEIw539wy9BRbl5kz7NkMQvHxU6b8l2
         IKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pA78VroF9WPZrSnfSVpCOb6xs8kbWqUSkVd+dTFpkE8=;
        b=B4lzinzSkTNZYcErT1x+W/aEFAbrcQ7LE8e4WhKtzhdjVC+KEMiVfFwn5DIlBdkrRW
         eG8xJw2aU1ifIp4wpxZLfbiiJgM4dSgt/6QhqFtuenNqKsnrxEhHzup54DriZTD8HaHY
         xH5LXM4XIkLfo2YPZTv0aztkumR5JT8wYJnUGz7PcLcxZIi8oFWVue6ugmY3706o2DS3
         FFuTDzN9jGv/9nrJqBo94MsXm5A6R+5m6bXzqdizcDL7tT5iyp1wX7iAfPajx1+Xz1V+
         XXZegv7cNHhUq1OAv2zcuftI1ufNqiHrTx03KTDPpasfzY3TnPX14H31rdzTrXe+aEbu
         nGwg==
X-Gm-Message-State: AOAM530UDkFlNTiMxsQARVO4hCW5CXpZjd7RdsCGFZL/lh2vZfpjgItM
        Go+cGd0HhPFqDMkY2coZ8E4fynna74A=
X-Google-Smtp-Source: ABdhPJz185UhvLjGwS3QxpUQdOrj5N8HeYobXdOeUqqOWRBP/yAcQ0sNXhqdw/OsOdF1vCw48Lplzg==
X-Received: by 2002:a17:90b:314a:b0:1e8:5362:5620 with SMTP id ip10-20020a17090b314a00b001e853625620mr7582214pjb.9.1654422006103;
        Sun, 05 Jun 2022 02:40:06 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-21.three.co.id. [180.214.233.21])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b0016362da9a03sm8415725pla.245.2022.06.05.02.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 02:40:05 -0700 (PDT)
Message-ID: <dea883bb-8938-5b07-0a13-92e8029414e8@gmail.com>
Date:   Sun, 5 Jun 2022 16:40:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] docs: usb: fix literal block marker in usbmon
 verification example
Content-Language: en-US
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220604155431.23246-1-justin.swartz@risingedge.co.za>
 <5f00819a-cd52-a2c7-77de-28a4649c33dd@gmail.com>
 <f2943c036e1dd403052dcbd09ac4eeae@risingedge.co.za>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <f2943c036e1dd403052dcbd09ac4eeae@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/22 15:58, Justin Swartz wrote:
> On 2022-06-05 10:39, Bagas Sanjaya wrote:
>> On 6/4/22 22:54, Justin Swartz wrote:
>>> The "Verify that bus sockets are present" example was not properly
>>> formatted due to a typo in the literal block marker.
>>>
>>
>> Missing second colon?
> 
> That is correct.
> 
> 
>>> -Verify that bus sockets are present:
>>> +Verify that bus sockets are present::
>>>
>>>      # ls /sys/kernel/debug/usb/usbmon
>>>      0s  0u  1s  1t  1u  2s  2t  2u  3s  3t  3u  4s  4t  4u
>>
>> Otherwise, the literal block rendered correctly.
> 
> The block is not rendered correctly without the second colon.
> See: https://docs.kernel.org/usb/usbmon.html

Thanks for the explanation.

I mean that for the literal block part, it renders correctly with
the second colon (which this patch is about), so the documentation
error is fixed (although not reported by Sphinx when performing
htmldocs build).

So for this patch, I gave
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
