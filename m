Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0064D546B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbiCJWP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240265AbiCJWP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:15:56 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E591F1965FB;
        Thu, 10 Mar 2022 14:14:54 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v4so6518604pjh.2;
        Thu, 10 Mar 2022 14:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XITCTKTL8wTpYtfXL8q5ribYE0GIZCZ8osIyt5sxi5Y=;
        b=Wf39KxDBRAPvKdUnV3oTpsDm5l1oTrqTwjWBCaLsuQVp+cmCPTWAwOkI9WeCQl9tU6
         l9XL3gJ3EYsF71msmPftotiPU73NUbVvktAlP5TsLdmZrbdo7EeXaoj0eEsq4AbWl428
         AjehmrOqfBudS42mtlmmByoQBHMI0htiiBupmHlGF4aoB3pufLfmTgjP4E7ScOrvA9F5
         wRqkjIlkrEmGPoX/WRsO0OzCwNOAZvf830LqKmOuQOxW3Hlljd7q/8LuvOSFI1N9B6YF
         ukxn2bLa/E96iYp8IQp2MBs47Avs1GIXfpf09g1RQtafzoBHDzfNKnEXInDb43FQri1L
         5mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XITCTKTL8wTpYtfXL8q5ribYE0GIZCZ8osIyt5sxi5Y=;
        b=VBiSmWZKf7A3D00QgOvNdQd09lVa9kmRyrMxJSYGKv0Zm2Gqq7+ytvSvO6C0Bn87K+
         VDmpXJX62B6IvNJUjYy9uPpcQlkVNEXa3gGmRH0Vtt4jF/DaDsA14+0b0zyREoBPyyJ5
         aFEDyTORH9aMT82VRQPZaTNu7dGutt+TSkq0U43p36EjFCP7gBCaOIJwQb3ePJqr+VLh
         33rzF5IfFbJOp1tHuxq6zDq9SQPhSzNkknW3HqK3wsybN1eK767Nh4MtdVpLK2/E9lOk
         Ekguyb2KGnVWJ04wKsPGeRMUS+IJmg9FJJalagoxqgPrqggeX73kdlnK49NClTERC7Vl
         cbBw==
X-Gm-Message-State: AOAM5312T4W7G/2VJjvrzDdgNmClpnmYtJSGmeylPeUswtGU6623wnxj
        atELaZWBmY/bOXq+c1SOcR0=
X-Google-Smtp-Source: ABdhPJwLoUcx+V47MOmygwp79EL7GO8tDOu3EAg7WY+RIdu2wQvlAwtvWczrTnq3Qu3ICVgpBysQlA==
X-Received: by 2002:a17:90b:3143:b0:1bf:8187:3689 with SMTP id ip3-20020a17090b314300b001bf81873689mr7390989pjb.184.1646950494461;
        Thu, 10 Mar 2022 14:14:54 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d6-20020a056a00244600b004f701135460sm1998554pfj.146.2022.03.10.14.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 14:14:53 -0800 (PST)
Subject: Re: [PATCH V2] tty: serial: bcm63xx: use more precise Kconfig symbol
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220310221246.10009-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <68b8f56b-1d23-1065-50ef-80cfff6a7d73@gmail.com>
Date:   Thu, 10 Mar 2022 14:14:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220310221246.10009-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 3/10/22 2:12 PM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Patches lowering SERIAL_BCM63XX dependencies led to a discussion and
> documentation change regarding "depends" usage. Adjust Kconfig entry to
> match current guidelines. Make this symbol available for relevant
> architectures only.
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Ref: f35a07f92616 ("tty: serial: bcm63xx: lower driver dependencies")
> Ref: 18084e435ff6 ("Documentation/kbuild: Document platform dependency practises")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
