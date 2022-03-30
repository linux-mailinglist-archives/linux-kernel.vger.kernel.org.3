Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DAE4EC790
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347627AbiC3O7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346654AbiC3O7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:59:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9CF103C;
        Wed, 30 Mar 2022 07:57:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 0C4131F44F77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648652255;
        bh=5PBzAKoMPAOoiJnmRA3I7RiNV9us3YDOcHeaI9Zs+UY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LIPZwiS3U6pUt3CwlLS3jPGJUerj1P2lWe3qmgg2LJsC2xxVUcaXeAe9F5fWgMMcG
         ebciEwOgIFCjY9AFADzXsMCmRLDa+uoSQC6f8soi+eDPxCe4Q9Cyju4C/HpTKKbMq3
         fvtamndKQOTZAMEhzsFqkRuHbfAPoz3CxDwaQjK03Va4r3ho1sdMsPME3RazTfBznM
         fIkuSJwTpAVtYXv2257OCBgfJ71E5uG9lIHTT0ohsNljN9bSO8jpop8NbfFQMpHM9h
         yzogCHUM4S269h2ezt/WMHcKbbdZMwERF6ArkM/yjCNfKAMVl5yZhObzTl69W5Nbn7
         k+4ptWmN+x0Cw==
Message-ID: <1d005ca1b58d9ec0882926e7148363b41f69cd31.camel@collabora.com>
Subject: Re: [PATCH v1 09/24] media: v4l2-mem2mem: Fix typo in trace message
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 10:57:24 -0400
In-Reply-To: <20220329135704.t32g4ksojxrjggov@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
         <20220328195936.82552-10-nicolas.dufresne@collabora.com>
         <20220329135704.t32g4ksojxrjggov@basti-XPS-13-9310>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 29 mars 2022 =C3=A0 15:57 +0200, Sebastian Fricke a =C3=A9crit=C2=
=A0:
> Hey Nicolas,
>=20
> On 28.03.2022 15:59, Nicolas Dufresne wrote:
> > On -> One
>=20
> Hmmmm the message "One job queue already" doesn't sound correct. I think
> the message wants to say that the buffer is already on the queue.
>=20
> We could maybe enhance the message like:
> "Buffer already found on the job queue\n"

I think I read queue -> queued. The new message would be inaccurate with th=
is
suggestion. I'll just drop that patch in V2, the fact that this message was
miss-leading to me is irrelevant to the patchset.
>=20
> But this is not a typo from my POV.
>=20
> Greetings,
> Sebastian
>=20
> >=20
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > ---
> > drivers/media/v4l2-core/v4l2-mem2mem.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l=
2-core/v4l2-mem2mem.c
> > index 675e22895ebe..53c2332d5cbd 100644
> > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > @@ -316,7 +316,7 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_de=
v *m2m_dev,
> > 	}
> >=20
> > 	if (m2m_ctx->job_flags & TRANS_QUEUED) {
> > -		dprintk("On job queue already\n");
> > +		dprintk("One job queue already\n");
> > 		goto job_unlock;
> > 	}
> >=20
> > --=20
> > 2.34.1
> >=20

