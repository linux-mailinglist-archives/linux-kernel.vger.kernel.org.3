Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B44459C995
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiHVUH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHVUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:07:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9668A4CA2F;
        Mon, 22 Aug 2022 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661198859;
        bh=dXpn5pHIlG3QJlIra6cx9HEfiXeMoNnRQ6WKhIoZGP8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Dk3l/7qVbk5gZ1+qR/XYUUvjOt5dTjw5qok/vC0c2hj7rdB9FHK3WFuZcZ/BAMEZv
         X6kHsRC3MQxinclZto+I0kGeBzyh9vKPvqPDwJY0HZIZpoWtssYC4eZlSbgWMShvgg
         rrxeWFBR39Hik/7bBJ9MTA20Y26Myiid5s9lZhA4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.190.222]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mjj87-1p9Qcz3YLb-00lBVT; Mon, 22
 Aug 2022 22:07:38 +0200
Message-ID: <7ac99deb-33a1-ca62-510c-e319c759934d@gmx.de>
Date:   Mon, 22 Aug 2022 22:07:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] video: fbdev: radeon: Clean up some inconsistent
 indenting
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        benh@kernel.crashing.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220819110659.110384-1-jiapeng.chong@linux.alibaba.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220819110659.110384-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8LWOlxNoMfqPWSTSrv2LuGaTgY/RnlafGOGKIzO9xUNi6shY5P4
 kjwUAg3gSzLawWn44VZZwUlmBF+FtAJf8QjljDjA4wgYhHrf+6myYHVq4AzkR5QXUU/jrXJ
 f5PX+v+GNte1QqB2RtWuOwY5NcQ27K3iNW5tuQzPwyvlVYQhfj+hNG2iG0T9uMMF1qucQGZ
 ir9cui8yyAu5l8UBCzg4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iepqQ7dUop0=:dfvAPfQXoqVBNxapVO52QA
 FXMIlEesCEpsPgBL4u+WqFZ9gHqnfhJhoYc/BaJOkz8c6xHlAe7PyH3eQ098KZnZQR/rjoW+W
 qcMDwQTAtXYHsnb8XrGY+f66mKidBbtme6xw+fClTRgMWrRkXOjNz077di2IcI0ancKSLWD1v
 T6wAOfhX1/jRUiT9MSks9IlamI0vgdvLXWw7n0luINaPHgjakf2sGZb1EXVCJJwphrQclR4rn
 OY399LNqd+utAfLlpAdqDKr/eYEgE2KQyiEm5YgGSJIiOqUxKyxOcgKR0ceTL0R3YnKlFLmNH
 fewSzj44Y6trRAGI16HR9Bl2Tc/BzaoXE4cbkaWeUe3tCeCMzBcl8s0zAVKoqI9YR1PL5lnCT
 K1r8AhT1uo1VPI/MEPszaS7tTO28GChLjF9qMI4LOznZPMLvPTuz/PxefEgtFJz36UgqHO7f3
 DX76ATSMoMQ92rxKVEhbQ1ad//xyXlJxA5D+2aU9Bla9YfWJm0x8GZXAdyjW0jT0Rmk67Vu1V
 tJmU+cQrdZJUXujKg+dw98ctIUC03FYAjgI4r/OB3r1XgzziLeAC13mO8HHDr5P8gSaGsftF4
 /hIsPcIixjleB/fMlEDWQ2FDKnOiQd+l5jJPFt25zJ8KIrQIImhGmaEkiFIQTz/Z9NOzGTb9C
 V1g3UCNk6/e0aTyBWZjcWf4p4N4gr0Tt2GgFf5wSetbsOjowyQsdLLP0ViKap2KNw97EWvCLq
 V0T4mlbS2BWYoLHMputEM+GUbW5Un4lKiO6kk9P65UdkcdaYgs/LQBWEgcTD1EtAvy/EDAOyq
 oIk5bQsQLaA+wrDJa9kgKfudzPXbhUQMWc+on/aar0GPbzoOKNYHGQX+VTBaUT4IR7/t1+Mv1
 gNozYhNS/Zdvp9fTyBzDcgr1lAKwfmZRRH50Npt974DZV0vR2ft9Iz7ODU0bqvtKZq2C7xFL9
 u7giPLjcY3hMygx9RsuJYZHRVUeAj7tINS68hFkfD7CmQg7DprYgC09kVlWUeLESTBB7CdCqb
 aJ0jcgQy8H22z9XD4rNW1M2nFoihykoarlttDa93SnkDVx2n6QXGQ+71bws+S0flZVz35y2dW
 4e1UXtx2cdmb87wC4emFwygJLLFBpoz7sZbfGS451Hk+ErbB6b+IhdMyA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/22 13:06, Jiapeng Chong wrote:
> No functional modification involved.
>
> drivers/video/fbdev/aty/radeon_base.c:2107 radeon_identify_vram() warn: =
inconsistent indenting.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D1932
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

applied.
Thanks!
Helge

> ---
>  drivers/video/fbdev/aty/radeon_base.c | 46 +++++++++++++--------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev=
/aty/radeon_base.c
> index 0a8199985d52..1e6ac7ef3e73 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -2095,34 +2095,34 @@ static void radeon_identify_vram(struct radeonfb=
_info *rinfo)
>  	u32 tmp;
>
>  	/* framebuffer size */
> -        if ((rinfo->family =3D=3D CHIP_FAMILY_RS100) ||
> +	if ((rinfo->family =3D=3D CHIP_FAMILY_RS100) ||
>              (rinfo->family =3D=3D CHIP_FAMILY_RS200) ||
>              (rinfo->family =3D=3D CHIP_FAMILY_RS300) ||
>              (rinfo->family =3D=3D CHIP_FAMILY_RC410) ||
>              (rinfo->family =3D=3D CHIP_FAMILY_RS400) ||
>  	    (rinfo->family =3D=3D CHIP_FAMILY_RS480) ) {
> -          u32 tom =3D INREG(NB_TOM);
> -          tmp =3D ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
> -
> - 		radeon_fifo_wait(6);
> -          OUTREG(MC_FB_LOCATION, tom);
> -          OUTREG(DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
> -          OUTREG(CRTC2_DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
> -          OUTREG(OV0_BASE_ADDR, (tom & 0xffff) << 16);
> -
> -          /* This is supposed to fix the crtc2 noise problem. */
> -          OUTREG(GRPH2_BUFFER_CNTL, INREG(GRPH2_BUFFER_CNTL) & ~0x7f000=
0);
> -
> -          if ((rinfo->family =3D=3D CHIP_FAMILY_RS100) ||
> -              (rinfo->family =3D=3D CHIP_FAMILY_RS200)) {
> -             /* This is to workaround the asic bug for RMX, some versio=
ns
> -                of BIOS doesn't have this register initialized correctl=
y.
> -             */
> -             OUTREGP(CRTC_MORE_CNTL, CRTC_H_CUTOFF_ACTIVE_EN,
> -                     ~CRTC_H_CUTOFF_ACTIVE_EN);
> -          }
> -        } else {
> -          tmp =3D INREG(CNFG_MEMSIZE);
> +		u32 tom =3D INREG(NB_TOM);
> +
> +		tmp =3D ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
> +		radeon_fifo_wait(6);
> +		OUTREG(MC_FB_LOCATION, tom);
> +		OUTREG(DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
> +		OUTREG(CRTC2_DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
> +		OUTREG(OV0_BASE_ADDR, (tom & 0xffff) << 16);
> +
> +		/* This is supposed to fix the crtc2 noise problem. */
> +		OUTREG(GRPH2_BUFFER_CNTL, INREG(GRPH2_BUFFER_CNTL) & ~0x7f0000);
> +
> +		if ((rinfo->family =3D=3D CHIP_FAMILY_RS100) ||
> +		    (rinfo->family =3D=3D CHIP_FAMILY_RS200)) {
> +			/* This is to workaround the asic bug for RMX, some versions
> +			 * of BIOS doesn't have this register initialized correctly.
> +			 */
> +			OUTREGP(CRTC_MORE_CNTL, CRTC_H_CUTOFF_ACTIVE_EN,
> +				~CRTC_H_CUTOFF_ACTIVE_EN);
> +		}
> +	} else {
> +		tmp =3D INREG(CNFG_MEMSIZE);
>          }
>
>  	/* mem size is bits [28:0], mask off the rest */

