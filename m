Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0FE47C12B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbhLUOGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:06:43 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:44935 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbhLUOGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:06:42 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTiLj-1mtqk120hJ-00U5ht; Tue, 21 Dec 2021 15:06:40 +0100
Received: by mail-wr1-f43.google.com with SMTP id i22so27127046wrb.13;
        Tue, 21 Dec 2021 06:06:40 -0800 (PST)
X-Gm-Message-State: AOAM533EreKVYHRdsOqxdu2CfSM+jfTWJ8CoIzQj63yzl6Hg830IIZag
        64jl4sYYM4AedDiG6jS+ZalVB6CDTghYEmneBu4=
X-Google-Smtp-Source: ABdhPJyzvQ/1QAK1GqHOaaSnEoVf7yge/oTnq2f+7MJ+Itino1uirIiewhJO40OrvktYWj5bEn5HdqsDGLHkkhTqttQ=
X-Received: by 2002:a5d:6d0e:: with SMTP id e14mr2899826wrq.407.1640095600018;
 Tue, 21 Dec 2021 06:06:40 -0800 (PST)
MIME-Version: 1.0
References: <20211220211854.89452-1-nbd@nbd.name> <20211220211854.89452-8-nbd@nbd.name>
In-Reply-To: <20211220211854.89452-8-nbd@nbd.name>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Dec 2021 15:06:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Qy8FJpACTqt85Enm72aJ=vzUfiEMZ4=dRqFmunyOm1Q@mail.gmail.com>
Message-ID: <CAK8P3a3Qy8FJpACTqt85Enm72aJ=vzUfiEMZ4=dRqFmunyOm1Q@mail.gmail.com>
Subject: Re: [PATCH v8 07/14] clk: en7523: Add clock driver for Airoha EN7523 SoC
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Crispin <john@phrozen.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ljYAPtxMHXEoMGCbEbbHrv5+Aa9r4tC90wLiKFQ/bmUyETO2HF0
 MoiLw0SvuWF8r0IxWuwrrwhyyPdC0SiqxYTJEd0GdF3hFCMIkJgrwIg1hjhhbk4FH0/1ea+
 QyDZuFCe2nPqEIDM5w+OhEv7Lrinuv6n4jR3TlQC1ityPh66H2XC/OMuwgn+X5FMJFsblne
 HmSzMrz4tzIvQzfnw8Qvw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WZq3tfczVnw=:+T+xC3CFS0KAkR58yvALwm
 urm0yX6vC6/NeBf8vqBT678Gvx0oJS9MzbE17yWjfIhU/HrgPNBRRceWpayVglFfHB3canvxC
 OoycIMAnSBlhLOSMM5kptXWOKxfALyfDhETRub9IeWWYXFHZRsiAu8gCIu9t3Voy6dXY3sI49
 fQc0LhhbaroGGsH8V63D1C59kRwN2USs1/LSPvoWXgTfsKZsqV03Scb39g8X8CXoVf6xfM8f+
 exvq07D3iocqgcLcPTYHhMzB8jT50DvUadVPyR002iZ7hwzLccxWm+BzS0h7qZrJh3p7lBRdI
 gBpwjTKikBnNldy7luGvskUhPQco0dxSV9RIuY25z88IzsYCp6bIY6i+igJym210DsGXXcR3e
 1FTmWl/4i+EFMyMDiWtZxL/QaLPMtR1y6u/+b/9gq6wYirzQ1Fx3II9vVBvPJhUsu4ZLpbTC9
 2iKIw5HUGgvi7Z5znKQ0GnP0nqhQXKpVmJMBKvTcn2gkTxTBWrENq/CaJCohJaW6LTOZm/1yJ
 pBwfi7iWcyupzogNbZuGmAQrjE1pdJwh3t7wAdkhF8lQh8td0wtJ/IsveCtOtvMAxhRHPxr4L
 QziH36W5laidt27LUh11GbOFWVkj+5p+hI6kBF3WOTPfrT9Blans6o3UcIacLK9DBAxe95MKA
 RSdKJTMHdWWDW0WrdnmUR0OhfIngDpSWAIE6e2TaAQWSGvrwq5l71lbiyld/zSoc+rq1MmPs2
 PdRj4YksasiSotdZHfsOy6xi+XlSL9T/RGA5G/r9JbfHFQabrYvrq5PuS3DMcIIJgd9OXVPZr
 8eotii0EsCZ9UZRP4RuCfvwaizk+PjkroU1/5aq5wiL2KcyiZI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:18 PM Felix Fietkau <nbd@nbd.name> wrote:
>
> This driver only registers fixed rate clocks, since the clocks are fully
> initialized by the boot loader and should not be changed later, according
> to Airoha.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

I don't have any particular comments on the driver itself. I'm happy
to merge it through
the soc tree for the initial support of the clk maintainers are ok
with it and have reviewed
the actual code.

>  drivers/clk/Kconfig      |   9 +
>  drivers/clk/Makefile     |   1 +
>  drivers/clk/clk-en7523.c | 350 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 360 insertions(+)
>  create mode 100644 drivers/clk/clk-en7523.c

I think this should go into drivers/clk/mediatek, as it probably shares
some of the logic with the mt762x drivers in there. I'd suggest adding the
maintainers for those drivers to Cc for additional review.

       Arnd
