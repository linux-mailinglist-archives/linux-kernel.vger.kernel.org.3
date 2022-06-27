Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781FA55DEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiF0Grg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiF0Gre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:47:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACFF55B4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:47:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d17so8074456pfq.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xCPxGjJaAsyFE3J4RMlhHeQntDY2P3C76Pmfho3A3fk=;
        b=CmBeaLKR7W/A8HqA2j25vIfnucsmbhg8TLSBFzfxzsiH9QAS8mylx5+wpBCfQReqK2
         k1TNW5G5c/7bUdeA18zVVYoD2KwEbNRskpY7N5yr4ahIxHSdbygh+qJgPLYEJwflH+zy
         aLwR0O4WS7DK0hOW/Hbxtf1CqDWd41HtE0WuiXo5kgITMCClvfS3FI830u3Lkf820d3U
         oNz6NH44JGRscAmeodf4D9BgLONX1bgC+G3G6AFQfgLa66jEFKwrmTj2Hc50Ooe3Yp+d
         phxmCHxuCpUmT8Yp2uM9KwnGyy8dOk4Rk/u/uN6bVFN61tbvbA+QEF9FUmvQfMzi30Hw
         NijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xCPxGjJaAsyFE3J4RMlhHeQntDY2P3C76Pmfho3A3fk=;
        b=mtHrSF/Fl5k4N8LB8UeMkWHqc1CUyp7pn6ymgJsVcYF9l0uFoPOhEzHTtW+3RBqI1Y
         2GQpOi+SqabzjvP0pDHWcxHgtQQgXC9Vor9a2G/Mkd6Fz64zWFS67XWxhYopuYILP6JT
         fN9RS3wqv+LcYx6jcYVYJqSuYZcPF9Fx+9WXiDgGyaFslI/jqMioCitwQmqnoTaxdv/U
         r0wwlKb/vq2O2hBYYUOluUmHE1G0pBGQLg2bgQs6EBNfW5sovKZAOI2VB/hTHfvb0A+v
         P16SYDYZxGMKPsRH6mumchzOob+Rzk8Yn/6s8OELlDW9AYW2yqn1jQiWoLPURwksbnfE
         gbsQ==
X-Gm-Message-State: AJIora/n00mt6zVzK+1d4ct0oDs4yrLmxCt+Sb6VqS6puDNJxbWivPA7
        Rz0kY4wfF4f3mAiQXJ3752/bhMQrdzmgzg==
X-Google-Smtp-Source: AGRyM1t7HLndcAyIvyXpB7rVl6mTFd/KtuZcE1O6Sd6UdChQKOu33H9v/KMgeew3f6BQTuYYQnbPbA==
X-Received: by 2002:a63:242:0:b0:401:b84a:6008 with SMTP id 63-20020a630242000000b00401b84a6008mr11303705pgc.100.1656312452311;
        Sun, 26 Jun 2022 23:47:32 -0700 (PDT)
Received: from [10.76.43.148] ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902cf0300b0016a0ac06424sm6338366plg.51.2022.06.26.23.47.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jun 2022 23:47:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [External] PING: [PATCH] crypto: testmgr - fix version number of
 RSA tests
From:   Lei He <helei.sig11@bytedance.com>
In-Reply-To: <9C9200B6-FDF8-4DB3-A3E7-0C6BA65D69D2@bytedance.com>
Date:   Mon, 27 Jun 2022 14:47:26 +0800
Cc:     Lei He <helei.sig11@bytedance.com>, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <72B4C0B9-6488-4E7B-BC4C-DF6FEAB89B6C@bytedance.com>
References: <20220615091317.36995-1-helei.sig11@bytedance.com>
 <0610F5ED-98B5-49AD-9D58-4D5960EFB3A8@bytedance.com>
 <YrV7uo9E/5aegAny@gondor.apana.org.au>
 <062CAA76-7229-4E4F-A9A5-A2A9A47A1C61@bytedance.com>
 <YrZXly80TZhO6lBE@gondor.apana.org.au>
 <9C9200B6-FDF8-4DB3-A3E7-0C6BA65D69D2@bytedance.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 27, 2022, at 2:16 PM, Lei He <helei.sig11@bytedance.com> wrote:
>=20
>>=20
>> On Jun 25, 2022, at 8:32 AM, Herbert Xu <herbert@gondor.apana.org.au> =
wrote:
>>=20
>> On Fri, Jun 24, 2022 at 06:29:29PM +0800, =E4=BD=95=E7=A3=8A wrote:
>>>=20
>>>=20
>>>> On Jun 24, 2022, at 4:54 PM, Herbert Xu =
<herbert@gondor.apana.org.au> wrote:
>>>>=20
>>>> On Fri, Jun 24, 2022 at 09:53:02AM +0800, =E4=BD=95=E7=A3=8A wrote:
>>>>> PING=EF=BC=81
>>>>=20
>>>> Please resubmit.
>>>>=20
>>>=20
>>> Thanks a lot for your reply, a new patch has been sent.
>>> By the way, why this patch needs to be resubmitted. Please let me =
know if I have made any mistakes.
>>=20
>> You first sent a subsequent version that superceded the
>> original patch.  That subsequent patch was then dismissed because
>> you replied in the thread saying that it needed changes.
>>=20
>> Please be more careful in how you send patches and thread them.
>=20
> Thanks for the explanation, now all patches have been resubmitted. =
Sorry=20
> for the extra trouble, I'll be more careful in the future.

Here are the links to the latest patches:
https://lkml.org/lkml/2022/6/23/150
https://lkml.org/lkml/2022/6/24/357

>=20
>>=20
>> Cheers,
>> --=20
>> Email: Herbert Xu <herbert@gondor.apana.org.au>
>> Home Page: http://gondor.apana.org.au/~herbert/
>> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

