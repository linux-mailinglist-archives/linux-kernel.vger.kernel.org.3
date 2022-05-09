Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FEA51F98F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiEIKS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiEIKSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:18:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928F128135F;
        Mon,  9 May 2022 03:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652091254;
        bh=62XK6zJxU055tL7PZ4571/szLvXI08h0pLjjJJksoHQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=GGwpYB7rqQH6//z9zXUeAWZxGNZBprSkq62CYV4kl7Ru36mo4k5aSwEx0nJ9IfPeR
         h4nnELyrNG/4x9bQCjkSW1+rFtyZ1v/EAdgbqH+i0Mz3F5/c3Tc3LooarmfYmSkdY4
         ZLgZHCZ4XwLTv7v98SL2PAfsygJL35YNYzGu5yM4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMfc-1nbtRK2YmS-00EOv1; Mon, 09
 May 2022 12:14:14 +0200
Message-ID: <c3d382759dac2e9b0927c0074d95e1b930e8e8dd.camel@gmx.de>
Subject: Re: Issue With real-time patches on 5.15.y
From:   Mike Galbraith <efault@gmx.de>
To:     Joseph Salisbury <joseph.salisbury@canonical.com>,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-rt-users@vger.kernel.org
Date:   Mon, 09 May 2022 12:14:11 +0200
In-Reply-To: <35c5a001-61b0-09d7-393c-b46836d0b676@canonical.com>
References: <bdb23fe5-51ae-8873-a3d7-85f377877c79@canonical.com>
         <35c5a001-61b0-09d7-393c-b46836d0b676@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cCIWrvpd3XJr2ZdvboFCrs5uDHMwcRqzCzAWlNnqCvjEGR28Ypo
 EVCBvUSpuqbMrNMGXTPIWOSLFRm8t/OtEtvMKCTkPVrq6i8G31wXDmR43TS7/K1nGaVLPSq
 cftXmS46wDhPyLxLGp4B9xcZ+gpMRD1+UCh49RYQ1JAqQRmYnGwBeXxq30et8t0LWBfGQsq
 kNoaez7FztpW0YEGA990g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RPnTyqZje+E=:Wq+ancMX2WYzDksMkhS+7O
 UQmxA/YkR8gaCraaF4vMcEopDl1BeHyqhjOgIuF6vF9N+mF1iuszacfFkJFgZEJOpGel4poY5
 HcCJ3xKvXMfGQKJ9+eybr6LDUwBf5bazgPQRfEK6VPmiHJp8d6yK0Rrsj0JL68yRy7quJ4RCW
 LblMCaBReJTvYQzTFkViEUpDYjcXXVBK6m/xtx4U3wM0wAPJfHxZHNTK8r776KoXZ7hE7incV
 JQ4vBMIij7e0eqHYvhO5h8I2RWnDZVwLHw257DA8X77rN2jAHa1YqDSjVTivGWShWbPrWsfpM
 NzF5oR9G6Jy06KK7GyQCPD5kACXVA5jvL99DWNCy0ZbwKel9k+AeqNTHnNsTlXCubqtkcvmrf
 tLT4QsHP7IjJphOR33mjnkJXef0aAWptNQ3evwvEqFapWgF5pPUSe4VHuTDQQxiroJ+xYV74C
 9OAKW/3WI7oa9IuxGDjELjkxgMbsSg8eSZjwCnEk9145mAWyRl568CsByWgzZ9b/iTMuykaPy
 kUUjlDbaIIo3wplAdUYjxGugmEdDO2w2YZH7Kz/pzDFLGPbfmzdZJaL33RsG109a583z3KMro
 +Q3kvUabpENoZKkwvB63VMA/Qu1zkdfEm136NVPQQVpnx9zoKNCRbawBkd2qgIM1HRMyH8hnf
 BrSjAcXTE1ym2TfOBr88khcxrTEqV1BQNanlxRBkd5uXesEi5kTOHi8rPFwS4l4cflVGAzSKZ
 YTIvcOLFuXr6fdSTO5WI4dAARk/2sSOSI8bi1x7hHPSyYWcJoBaUN2F5zan5XiKh5yGHNROP0
 wjlRiW4+dFTUm6O1QoerrOWLiaIjc9ZyaZMZqSyrbAUWVkqbxK1G5HdY2cG7DkwCy8E44gW8l
 E/steqpQdynyaDszGb+6ozzUrE5gD29B/mffCIK2dz1BQgC7opxSY4ICqft679I/LFrdPdi2z
 ZVj7Mm55J6yUSH8KfHWFECWg9iyuLRpKZqg0ykbtcQ63fcmqGK8JN3pr0t5D1f2VEN+rCwu4K
 YsPfM8szhZIxapFwHu/Jo+vfQSGgW0ZBIXV68x4MRnWCwityAS3mGI3aiF1qRpcvcw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-05 at 19:20 -0400, Joseph Salisbury wrote:
> ...
> Also, the following is the build failure that happens:
> arch/x86/include/asm/pgtable.h:55:8: error: unknown type name 'spinlock_=
t'
> =C2=A0=C2=A0=C2=A0 55 | extern spinlock_t pgd_lock;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~

35fa745286ac4 was merged into mainline 5.17-rc1 to squash that buglet.

	-Mike
