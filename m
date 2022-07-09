Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AC556C88E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiGIJvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGIJvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:51:53 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2838FD59;
        Sat,  9 Jul 2022 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1657360305; bh=QbzLDica0La051WAJkKYiljdoWbJTf+xGdnDQC7A9DQ=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:MIME-Version:Content-Transfer-Encoding;
        b=WwANnCucEe81S6cnweDhwBjk8z3j81Vv5wdRveee6NDCp0Iy6tnvZ7/j3kd86/oLW
         Mib5JAlX5CKPqK7QcFBAWAyCzSAkQmaWYoZMUTubchy3LvwuJc/PoTglrW2KzSqUWM
         DFnSlmSSk0SSFz3LOHFJTrFYx5I/VNRawuTssadA=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.207]
        Sat,  9 Jul 2022 11:51:45 +0200 (CEST)
X-EA-Auth: KRAU0ikEIMrN4J4pbLJ8bTkc1rv3pntAf/mq04NS3h+YTgr4g96hFyNVub4qZWK6GCcHxFGX/fq3txkv79WRRt/Rmf0VQSwAA/OqvATDoNU=
Message-ID: <e17913649e255d91bc357d3ab3e70957d05493e6.camel@mailoo.org>
Subject: Re: [PATCH v3 0/6] leds: Fix/Add is31fl319{0,1,3} support
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Date:   Sat, 09 Jul 2022 11:51:43 +0200
In-Reply-To: <CAHp75VfwoSqLZVbsN3DduP=SEKvr=tSfmxF1MTnYma0zh-JsXQ@mail.gmail.com>
References: <20220705163136.2278662-1-vincent.knecht@mailoo.org>
         <CAHp75VfwoSqLZVbsN3DduP=SEKvr=tSfmxF1MTnYma0zh-JsXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 05 juillet 2022 =C3=A0 20:57 +0200, Andy Shevchenko a =C3=A9crit=
=C2=A0:
> On Tue, Jul 5, 2022 at 6:32 PM Vincent Knecht <vincent.knecht@mailoo.org>=
 wrote:
> >=20
> > v3:
> > - pick up Rob's R-b for patches 1 and 2
> > - reinstate bindings docs license and maintainer
> > =C2=A0 changes with Nikolaus agreement
> > - took Andy's comments on patch 4 into account
>=20
> Thanks for the update. Nothing serious, but a few comments.
>=20
> Also a question here. Do you have plans to convert it to use device prope=
rties?

Hi Andy, and thank you for the reviews.
Just sent a v4:
https://lore.kernel.org/linux-leds/20220709094642.4078222-1-vincent.knecht@=
mailoo.org/

As for converting to device properties, it will take me some more time
since I'm not too familiar with the concepts and how to do it exactly.
Got some hints from git history, will look into that.
Also I'd like to add blink support...


