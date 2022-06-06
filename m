Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BC153EB4E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiFFMJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiFFMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:09:04 -0400
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03F313DD7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1654517338;
        bh=/B0T83R1+kfGfUq/M4rvdp6k6LPz40DdhuY7qvcj6zE=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=G27tpIiAfQc60lQ1voiuMbaV3CP0WSptu/auSYepxqT62NwwidUSB4zhwLrNCRz8x
         yG5dEDJmBesIJRsFrCw3qkB97UruTv6zH0k/DrK4Ct+4d2kBTtL/RS8GXzvkDha61d
         0QopdryiVzrrPbSPNauvIl782m/awVVhVWVvq+v4=
Received: from helloworld ([59.172.176.225])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 238B9040; Mon, 06 Jun 2022 20:08:56 +0800
X-QQ-mid: xmsmtpt1654517336tcx4qb64k
Message-ID: <tencent_1A6695DC780E5B8A9AF00025F2FF35902007@qq.com>
X-QQ-XMAILINFO: Mrv6PNPZjcp6nSmgvFLh0TCE9MCLyPvN6db/86aukcOAP0TUaPNUq3XL/dB36S
         wGOKxD9MvYMDBG5BDyGhu7K1Uw+ugBzbCGeHCYZNddEOK2jLecMkhZ4qs7e1wjkg9/Sl1Jc71ReP
         w/t70N1P53dwj1Q+smzNsrfE+TkknPPsWN/ZmEMkahy/sWtO1Hd56d4FpnGP0sLH3WxOeWk0Y1ww
         /uvo5PlfkF+ePbi9oAGhjduOzQK783EnueYyPdWJRiRRtHS0dQ98HJXYtD5rDtnzQ6+wzKeS1NaB
         VSWhHuOld3gVnHfbaUvH4eU6MLc+CYTk76wZ7FRk8/E3zKTTMxxZuqwtnfEAwkNYdvQprQn0QlZE
         cq7fpqOldrFuzKSZ5di8wuejPXxFIc2vLzGU+wt3VdpCrAtwfCpRgu9oD/P4h2EEnUdHmSUaUYle
         nuveiTymcfSviwHuP3HV0whtvT0wVHoaxw8PLBLEZ6K8rZV6F7g3qIDWkz41KP7PUt0gDYxMy2AR
         AJt5n8Z0K187a19kvRM80HoI0kRGawYU+OBTZuNO7tGMKDCS5gtRrfVlL6VDOmDNoP8E1kt494AZ
         VtSeoEH5yjfKsUeJtdZrRHiS7EAAEpFeYJtukoJcTFazFBg7znblauJWvzcF4wD1fTn3OcEIbq+M
         Wu5uDB1d+gbgv52A14XspzpLxHrA3mWTEM5GB9qoXk513OSxjVZJiKrRC0veIwY/uKx1T9P1Dpdm
         AQ38dtbDPRGPShzXtAKFdv+e2btweAYI7TOFBWsiFYvOoMeGfNj7hBlueIwI0zPXu+/xhhzLV+pN
         O9C2+F7itRfBI2eR3FZpFlQtsAl1HoIxQPalXoxScY6F/oNeFitTGKMRJAoFU78z+THT17mIuNWa
         w7EBwlQMAQ1zLyrsgEf5NOgPB1gnIt43rqP/PxXQCdu9yMB9eAk18arfk+j3XHE9H3ca2rQI4t3I
         gPUnVy8+Rq9Efx4b/5P+WWjCdZZpuwBdaMZgMG3q+tUpOsCQjYKQ==
From:   <xkernel.wang@foxmail.com>
To:     <gregkh@linuxfoundation.org>
Cc:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com> <Yp2arAcg3DlgNT5t@kroah.com>
In-Reply-To: <Yp2arAcg3DlgNT5t@kroah.com>
Subject: Re: [PATCH 00/12] staging: some memory-related patches
Date:   Mon, 6 Jun 2022 20:08:56 +0800
X-OQ-MSGID: <001b01d8799e$32e08c00$98a1a400$@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIV0YZsN+y1sjhn79f1inyeXg2RTwF22BV2rLvZLwA=
Content-Language: zh-cn
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 6, 2022 2:12 PM +0800, Greg KH =
<gregkh@linuxfoundation.org> wrote:
 > Can you please look at =
Documentation/process/researcher-guidelines.rst
> and update the changelog texts of these commits to provide the extra
> information that this document requires of changes like this?

Hi Greg,
Ok, I'll see what's missing.

In fact, I originally used my developing tool to find the lacking checks
for kzalloc(patch 12 in this series) and the other bugs are found =
manually
by myself for the purpose of improving code quality.

Now I am happy to find the bug for checking the return of kzalloc() is
fixed now, however, the patch to fix it didn't even consider potential
memory leaks. So I'm a little confused about why these patches from me =
are
suspended again and again.

Anyway, when I have time, I will rebase them and send new patches if =
they
are still there.

Regards,
Xiaoke Wang

