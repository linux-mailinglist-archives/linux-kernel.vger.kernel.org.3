Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30D951B598
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbiEECDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiEECDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:03:42 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 19:00:03 PDT
Received: from geosincoor.roylabs.com (geosincoor.roylabs.com [193.233.182.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1AC473BD
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=roylabs.com;
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-Description:Subject:To:From:Date:Reply-To:Message-ID; i=cas.geo@roylabs.com;
 bh=bh9iyPqTwXbBCUbKpWQh+6Svj3M=;
 b=kZvxq3sLDHxsR9YUAkZl/H2sXsq3C/2UblKPhnwFMmf1DWdJXTarExGTIy6YXv7Ck/Kp+ajzx8Xc
   RI6ATzYr+4msm+YelCJA6ejr0MLrO2v023sF4MhoH4VC66IsJH4VTZ709l5mtz/B0zMfuSUpeveN
   kdf+uNq7VGXkDmMO02Eabsa1FT0jsl5dVVcN6Du9zAmGk3WldcuJcsyQ9WaTVyeK+2yKS+4+EhkD
   tR/UrZRrWDoCrM3eEUzIyJ6rxyQ/FCkMNbu6SJar1mer91ierWQ/+Ngkl2OBv5e7rye6mhKwlohA
   UF4zkDMSkdPtMANecGOXiXYfVb76lhS86rAU5Q==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=roylabs.com;
 b=NAwu26RrWU/kGiVz1hv/hzUBmo8Mh+5bfG2LKlLH2XnHv5hKpyUeesOIxQWEVVrxndTnFjQRQL2P
   XGD2lP/JCyWEIM6MiEz2fk2qwVcP91lqoLh1VEjT7yh4wTeoaMUboO+eAUUKcF5t9yIY0U4EsDKA
   CYEyhYchlhqWOsjt6HOeBV9G14f0avnmMq4+UvGxZj5T9zdATDRbP490yldmSV53Pyo+IYTbPEs7
   eEIaeSJgxoXLl9KVL9iP+NDfsl2OB70yxnDd97wahgM0yhIYGJC9AVc3wJNj6h6AHuAS1pB0vUGk
   ZAc5AeOruBnX//yhvNQko5PpMtsGcjtC1P05RA==;
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: Good morning.
To:     linux-kernel@vger.kernel.org
From:   "Collins Fuller" <cas.geo@roylabs.com>
Date:   Thu, 05 May 2022 03:29:56 +0200
Reply-To: collinsfuller1@yandex.com
Message-ID: <0.0.0.7FF.1D8601FA1DD2B10.0@geosincoor.roylabs.com>
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [collinsfuller1[at]yandex.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

How are you doing today?

My name is Collins Fuller and I am a Research Analyst with an Organization =
based in the UK. I have a lucrative business proposal which will be mutuall=
y beneficial to the both of us. Kindly respond to my email, so I can give y=
ou more details.

Regards,
Collins Fuller
