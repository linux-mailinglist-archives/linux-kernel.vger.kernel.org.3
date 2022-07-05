Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA02056758D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiGERZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiGERZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:25:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD561C925;
        Tue,  5 Jul 2022 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657041925;
        bh=VGuEIUsr6EgBwogMJDOlNkr+9uptYB5Wf1LvyW7VLPs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=BR4Ka9eBTIpMKugZr0E/hxB5KRHf+PGynZ8p8YeN3txlsQYJjeEynmJqhY1ofHVlp
         8tk0LpZ3zR1G9O7AZtFlKbMwEDZERSKvVpIQcocsGh49ypzVDpAS9y42+7Qhhj24Xo
         OohDN5QpJ1VJrRWWZaMXxT0QyiOnjvSqk4mb+aiE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.101.2.50] ([185.104.136.29]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv2xU-1nI3Dp21S4-00qzDQ; Tue, 05
 Jul 2022 19:25:25 +0200
Message-ID: <3fedf676645bfa638c9a6c656121083abc2c98ea.camel@gmx.co.uk>
Subject: Re: input/i8042: Malfunctioning brightness keys on HP Elite
 Dragonfly G2
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Tue, 05 Jul 2022 18:25:03 +0100
In-Reply-To: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
References: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Provags-ID: V03:K1:M2iBMc0im9Qs1j7rs3F8242Bvqu1RzrWcKErf4FO8nCAIlTPabO
 XezvY1x04Hf/yKXPDunlpPrs+U8YtiPqVlkk80SVgOZMLtwpuhDSfyxPf0KEG2wzuZ9VHs8
 B+CK1nVJeoVtCnEQZXLDGhvWv+u7SwPQoqT4HjsyvPvCzBL5OdGqAw7RwzbLih2mXaC6gpx
 iJLywH42L9aNDa7fXvb7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V9OcqCDmAAs=:Y+kXprhGKORiHtVYvahpT8
 xda3TBWhB3eAzXje6wJh5hneRkkuLIQps2P4iqbu3bDMFJ38daXrMiROCsfKKkTmAckjwoL3e
 50v+J+tsHf65cXvhChkKgC6Mu6s8bNwxovgA8ntAak1vQtGOnD+m0T9zulJkwQuZmFOtV09tl
 /Ez1S72NhMNlXggpGGpYVOWQqUjiiKShrT36MmT2wAQvHqCqHzDfB9MGuaSdj28Bie6ApB8Uc
 6VwHptdhCC8tCPGm1clO/p6f1sxqH6ZtR0FTtlQut4mWKl5xulwRJLCTNB9tVmbqL/+MzSiKZ
 sO7o+4C/gFJ31rgMgQanVWgDHtZpEkKSUe+u2yFlTXdP1B0jgfioZdOPcoaQWaNmxX0qrQbNX
 W8y2ZoX5crwdVcGqHI/m/b8yQWM9A6JAy2Scn4IfPXH9Yq+G7pBeDqyfo5449BJfk5/nOzqP0
 VJtgPsncKUm/uROiwxdLeMqbExJyfvNwqmVhwY0LagTjTRBFe3a4clyxxek+ehib5mDTERMMI
 Cm7FWDQx1Li29LwlV/HBueHFP6SdZWHhht9tlcQdqlYn4HplXbAqFU4lcit58SOsahWQIAKqO
 7zxGsQBdaNe9y/nvIBfZ4zX3C4IpdtqlXocpjj1lqstPJQ3t982S8qR1PRSQUPxjypS8d3df3
 6TqyKT8QjDiHaooRUW59nsFEK9sX/NgcA6OeTPbjZLEUvY6+yNB+3wOGLEmhHu/qv/0RNer5a
 mJlpLmjMMOHG+wo77hFZQ7/aDlZ9btXOMj5vcL1SQa4W9agSUhZLDsPWXiVfqd7iy+S1rnG6q
 lSnt0XLGJ/LyqD+8iaYvS9kjXgyiJi9CFgSbu/Wl6c5CmWx0LqW0nfiBnznCDr7kvzt7jUuG0
 FwLxZ6vwkH5m2qN0d5QMe16/y96SVJWFgPxddVwe6Jpl1lpECQA6r6aTMgybpM/3a8lYSWMml
 dzLyg7U5R47KPG54shf+aIIlIUiK9k5+w21z8NY/RYv6S196m/uniX+ZKzirOW6pq9WV/vqO0
 OGlD2j60VcMef02e5SynaJ4F+V8C4UkqFmRD2yklTaG6i1xgLct36MCJz2xDDBag6BnDazKbu
 095OlxYyvURiaPfy7/RF8U34bGKjXFEg8X1XhXpZ7LHarQYt0P2ypTCIg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping? =F0=9F=99=82

I'm also CC'ing the x86 platform people into this, as I'm not sure
whether this problem is something more within their remit.

Best,
Alex

On Wed, 2022-06-29 at 10:43 +0100, Alex Dewar wrote:
> Hi,
>=20
> I'm running Linux 5.18.7 on an HP Elite Dragonfly G2 laptop, which
> seems
> to use the i8042 driver. Mostly things seem to work (including
> hotkeys)
> except that the increase/decrease brightness keys instead send the
> "mic
> mute" keycode. (The *actual* mic mute key works fine.)
>=20
> Any ideas? Do we need to add a quirk?
>=20
> Best,
> Alex

