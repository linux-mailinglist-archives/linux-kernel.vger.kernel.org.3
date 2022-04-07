Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376D64F75EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbiDGG1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiDGG1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:27:31 -0400
X-Greylist: delayed 7369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 23:25:31 PDT
Received: from se1d-lax1.servconfig.com (se1d-lax1.servconfig.com [173.231.224.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7CF39161
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:25:29 -0700 (PDT)
Received: from ecld309.inmotionhosting.com ([198.46.81.21])
        by se1-lax1.servconfig.com with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <broker2@muneshwers.com>)
        id 1ncJfJ-0005W8-Rn; Thu, 07 Apr 2022 00:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=muneshwers.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        Message-ID:References:In-Reply-To:Reply-To:Subject:To:From:Date:MIME-Version:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9/QrxG4h2nwiHwigMh27+L84D0ydURc2mLUXe98JDXo=; b=pc7EL2d/gp/QGNR2D3noud37El
        dOksSiW2k2eCVRUkj4C5/5vLy/RQRDtCX6SOCqEwPUg1Q6HC1WAwtUiN2Km9fyrwqdqIG9qhHS7N5
        mt36Sc4ynsElQ4Y7QTAOjKhoQ2ghIsDqMRHXPMeQE1EFgyyArueRFsDCZA+5v109Y97ODnLvKen7T
        VNy0xbcsgYzPz0Ra20t4h5vtIgPQo/AIbcuDzO/0Gmt0dfCUP74wTdq7ZiVSXI1ncxC6CDvz5208J
        h9tKarLJEdr2DvLKPdowmmfInAKwnZ11hCR+eQHS0mINJhw0ArWKBvWZvOUIAbxT/8qgtB+gTZhDb
        1X/PIoaA==;
Received: from [::1] (port=47714 helo=ecld309.inmotionhosting.com)
        by ecld309.inmotionhosting.com with esmtpa (Exim 4.94.2)
        (envelope-from <broker2@muneshwers.com>)
        id 1ncJXo-002OuS-BB; Thu, 07 Apr 2022 00:14:52 -0400
MIME-Version: 1.0
Date:   Thu, 07 Apr 2022 00:12:56 -0400
From:   Ukraine Needs Help <broker2@muneshwers.com>
To:     undisclosed-recipients:;
Subject: Support the people of Ukraine
Reply-To: Oleksandra-Iryna@activist.com
In-Reply-To: <6c59d1855bb504e98f7ca74cfaa8584e@muneshwers.com>
References: mid:4290 <44d7ccd6bede2798824d66b1bd6c7daa@chanofan.com>
 <5fc829c999fe4b45c878540b04fdf071@presidency.com>
 <944a7a1c7f978d3cc2c9da318a675ad6@totalhospital.com>
 <0fa73b5f7f95bb3a31aea07a8f4b1784@ukrainehelps.gov>
 <749444c4ffb0114b7e5a4149a7b00399@presidency.com>
 <4af43a9298dbfa4d09a5849d71b5e58a@ukrainehelps.org>
 <d7decf33455ce2a66e1b922ee175fd0e@muneshwers.com>
 <08311dac5fd8a00db75df782f8148cc6@muneshwers.com>
 <6a061002f988daf9cc5e12a93de36bc4@muneshwers.com>
 <53523f5e9aef4b2febd2d4accadff0c9@muneshwers.com>
 <bf25947bd30ae37f0b9392f4dec38f6b@muneshwers.com>
 <8060c3b3d18e19ea4ef15cd2de108864@muneshwers.com>
 <f7a13c914b5a5257a3a6dd0eddcdc26d@muneshwers.com>
 <6bf79a4425a6c2f1fac8ef34fff9fd04@muneshwers.com>
 <aaf96c71fabd2e2e531a83d4c3ba9ed6@muneshwers.com>
 <fa01c4166db07c7493fa72c77a27b87d@muneshwers.com>
 <acdced663001f9c5bf2772134aad8778@muneshwers.com>
 <e27db0e21bd76199ccdd9c82d8f7f72b@muneshwers.com>
 <4fe4e6b1f35057b7dbec178ec383aaff@muneshwers.com>
 <c33ab59d079b40c88138ef3f9c7fa313@muneshwers.com>
 <1c7b341c472134a651216631d02a73cd@muneshwers.com>
 <b34e0aab26b1f1206bbf2e795fcdc774@muneshwers.com>
 <28d74c19e433dec67b34af5320675ecc@muneshwers.com>
 <07e1a2f8ef15775823ad97f19b752298@muneshwers.com>
 <c7139fa76dea378d50d5bc428e9a23d1@muneshwers.com>
 <ce2726e868d8fcf17cc383ad3ac8d9b3@muneshwers.com>
 <6c59d1855bb504e98f7ca74cfaa8584e@muneshwers.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <ef9f78f7bd93b2c209f3d08b9da4ea19@muneshwers.com>
X-Sender: broker2@muneshwers.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Get-Message-Sender-Via: ecld309.inmotionhosting.com: authenticated_id: broker2@muneshwers.com
X-Authenticated-Sender: ecld309.inmotionhosting.com: broker2@muneshwers.com
X-Originating-IP: 198.46.81.21
X-SpamExperts-Domain: ecld309.inmotionhosting.com
X-SpamExperts-Username: 198.46.81.21
Authentication-Results: servconfig.com; auth=pass smtp.auth=198.46.81.21@ecld309.inmotionhosting.com
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.87)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8k5aczGxXSKAtar6YA2YsAPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5x6WDsrNdK8H8Azv5V8eZsdxzijVFv96CNnaueZx6Y5CUJE
 IjBk9flt5+voJI9UDOHExJvpPH8YuswlYO8HbWKx7uDjV/sFUXQr+CDrNQuIHisenvNkIa5eS4fe
 f1Y2alSQhkMjP8O+s9WAD8i6FNP7yBmUa/1kvunooZaSkL4yMy+0daA4z6nyRODTInr0Y+HX/EGy
 u+/YxgVitLxw8V82dbgv3yCrggDESGI2CgX6gnHbzdRzUmeG73E8egJe2alVJIf0Ov2yH60Lt70O
 2gYZs2xrLo6jXdMDjgyBbAHveK7oApB1m5dZ3hsMlSxzsERyXKhRf361vnuPruXDpGVKm5xFyex0
 urHEOoOKtiqhxOTp25MWUAxJwvd+F+obdLz+CmqS1PCSUI4PJQTKDLHP+FPmy/VLVIsoDF3CwSyL
 usVVhJ/s5aayyzJa8VoRcniLEz+rZYO2/9vjaeyjkrpg/I66YSViZPhxKZYxPlrOxepgwkg/1W5x
 Xu/V0xDo5AMiSV+gAK6yJ4C1HGI0jfDhEXQWzb2f09J9EzuU+WbyLba0Qbf3EkJrQ9LhROHEnm1L
 BQ9uddgbHFeQ903egSWIMZWvkyx1nKb159x8kE8JqmszirgCUK8gsnxaz1ybKqJyDYASqdkTu3WE
 BzwIAouvJ5poUR+uZ/yJtRRyYeb/Ff6zY5TFjf8uW2Zpv2TiEEC8aOs77bVlBSY7ZwvogfYPKC0z
 Pr8KKQMuEdM8ZKvGsNZtHG2cqXrAajYHwGuLknr1W46iAr/QNrhUxevbEMIPV/r0Q67a6MI4ySdZ
 Ffld5AN2hjljo1mOOp6FZAoxFTcZrJgPpiPphMEZj1UNlCS3Zl0GsWI571saV2RvMxesnFSZIA52
 gihJahEJzzhi5Xv90nLjBhLLvHS+4oxhpncODzFUiq2P/l5R18d9rqXoEsXsiAtr4xCt1n3KJXwB
 KSE9zJf3ucuQqsVO/zJoz6l3mxkShIGCnRoPdUy+cHdZ2e03D/xjv3RSnbvh5T1Wd3ifpVqXD3I9
 CKAWHrZ3aOquTazQ97AWRQgxrPW2TwNIhGdeKmxq7/nmMxzmp6k+e35aadzVXnL1d7TFniutq9su
 4lnddzqVH2TU5u7AoyRDzMI/+yvtUpIjuIzUYohe9MqPbwETufW8KIzW/P6xXP2p+Fz6YsZkoecQ
 TgY1Btw9E1y4R4t7v7t8HZLu4AwN7qELfgeYcYUgxk2vnUvDQwxmRkT4S32xDa3Rdyn/VXh9T65q
 fSGV3OyFucnjHlwzUwm6BDCsDCT5e7Fj+GUZvgb8gvA9hROcHAEwSt6lCIQujUkjMQuuvPUrGpv/
 IbpYIpUI9Q88O5oI7uCCyhHltRL1+GLmTxWe+hgCfcvqbJXvCLbbl5Dw4NprgoPuACod50QcU5M6
 sWLYvSYjlBvKf73Ahl2pBchqpohXCVOKbSo/YA0f9Fxnt4nUt5LVrh5TtUG2VVV9CEgpFLD35ryW
 oxpIRAwX31WVY5lWjWxuGSRuxRaAr56E0TrfV/PenTeQCtrObKD0MHRuy8hOqlVfxfew5YE5enyc
 cp7RH4WQio3uGZtLH6lYvCDaX0/aPwImCpyNpBW1qUpHZ+Q8yXoDCCGbHSz3UpchRHoDmlxyn9Vr
 V8rah0XTm7MiZd8VV8kKgjA3OziTBNnmAz+V8V9nCj4NYmyxb4qH9acfHQUyKbywU99tR7f0MSJK
 k/gHE+pDJJAiK+Bvx1gbFDuRdKHkK2rCCipGBPz03F+GFmF5fvkA8P31xGE51v8dp66xZmymGm2V
 i6G4eDE6cmF8IcuLTykq7TPaxlMwt+nCrXglPxRdnDpHhE5yL+7ut4HC68EYiFyvDTpHpvGayLDs
 UiaPTIJ7GluVfnfj5db3fq6I7w/UMIjmbSunL44/qDgMJcbh21wRinJ51QscDzyRYzMsv5P4ZPHc
 +L4qQH73gMI+pWIt+nh73gIwvVojHYKqj/ckqhYI2OnDZolSRawWWDRGq2jSKS+kkwQivROHC8kO
 7fmGjs8ajjeB+8BHtIzTJn66EjmORdB7jX0QKBhUdcSGl3+trPbo/GzqhPc1ScKmLJN6KwtNFefg
 aeCBExup08JrrR22vSerFxAiTmWh100IqGGYTu7P8nBwnoYcO6k3Crvkl+v4uO3zf6kTcNnLkZ+B
 dTQ=
X-Report-Abuse-To: spam@se1-lax1.servconfig.com
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,BITCOIN_SPAM_04,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,PDS_BTC_ID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Trust you are well my friend.

We are soliciting support for the people of Ukraine as they witness the 
horrors of war and an increased displacement from their ancestral home.

We understand these are difficult and uncertain times, however as one of 
our compony principles to never leave anyone behind, we like to kindly 
solicit for your donation support to the women and children in Refugee 
war camp in Kyiv, Ukraine. I know it's hard to trust these days but you 
can do it out of love, kindness and support for humanitarian assistance 
in impacted communities in Ukraine and surrounding regions where 
Ukrainian refugees have fled.

Getting donations to people on ground in Ukraine is quite difficult due 
to the ongoing war and we have been advised that all donation should be 
done via Crypto Currency according to the Ukrainian ministry of defense.

Here are different wallet monitored for donation by verified Ukrainians 
on ground.

BTC: bc1q370ydpdk6euc4qfwntd34uvccyvl6myza059gu

Eth.: 0x9E7bB55e87AFfD04d5f5680430fF2098aBacFF36

USDT: B9QCqmfYhfbfQ5hkFJ815pLEFrD45MW78vX9KoNonaB6

PerfectMoney Name: Support Ukraine, ID: U33367369

We have team all over the world incase you want to donate via bank 
international or local transfer, also if you want to send via MoneyGram 
or Western Union, you can contact us via email to request for payment 
details.

Thank you.

Mrs Oleksandra Iryna (Muneshwers Kyiv)
Coordinator for humanitarian affair
Kharkov, Ukraine.

Contact: Oleksandra-Iryna@activist.com
