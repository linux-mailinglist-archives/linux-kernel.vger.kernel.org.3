Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B213F595F04
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiHPP1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiHPP12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:27:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5BF31DFE
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:27:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n7so1846800wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=2N6dolVsuda2FEMkXY2VEqjJwsDO/erIHXHssLLX2/M=;
        b=NPCiG0SVlRsvelVrlgwc0sSLcYgg16iGwO4yDVoUl1H77Lb3D3woASv+D9tWIqo/Ix
         zAdq0E02NAJd4EDjJcwRvIG54jiqUL3xcWJQsUSw5JB4qmgIoBQKwmLFjOIxnsQS2nWm
         GKjFZ0dXOvTTid/gNebMvj8XxK/6St/MzdBMbSUW8OOKvEOMhcEWOflK+dGOPCSzjgmv
         CgqDFXOLv6XA2s1gtOHXfsjdTkW8ResDanWPZwCjCgwwVAiGAGbO+E2UrCsETix3NN7s
         dSeJYxEVNGy30/qvjKaygipqAkfGjmOMYE77VLjNyhlk/wcbYggo22Bmj6X5doyxvteO
         2QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=2N6dolVsuda2FEMkXY2VEqjJwsDO/erIHXHssLLX2/M=;
        b=qx47yfyg6rYcIwGWrCgesGolUMaz0FvhN2GPdeQbrdbDRcB5DtAJS2YZZ/h8vnGkDK
         MZ3YVkqPv4Tg/otCWh31LL8kJdFvYmxvQRQ1Emin0OrgduvwqN9ztiwuU/VnhsS8PE7a
         +/L0Bd//luw0Hd0pa7WQNcC3zeXg4K6l0M7OxhwT5gs4WFpChiJPrthN4GnjrrxYjkJD
         lcSyFQ/XOFSjvqg6e8r+H+xBB4kVUWLakPG9M8dCetGpXDkRTWY7KTSAgirO49cf4ehg
         AHYUCp8rtR+NWrPhfmwdo0CANWB6qB3tnqhhHu5VTOL2duoaUf2gzzCkVBXJ4QEIc/sQ
         LbiA==
X-Gm-Message-State: ACgBeo09KWoLMjll1VQCdGa9AVQaQyRqzCvdZkSIZDMzKAE+uAsgXDJb
        WOdJsLwAUbSYL5gh4bhcEu2Isv2nVUHbwaERVt8=
X-Google-Smtp-Source: AA6agR4lAVOGNmpB44sX26Tc0WCmHzU/uX20PrsIRgBbvk7/d4tG8zCP6zyfnv3Vs3H4daj3X5BxpF3om2kqyqhPKzE=
X-Received: by 2002:a05:6000:60c:b0:220:757a:54a8 with SMTP id
 bn12-20020a056000060c00b00220757a54a8mr12066182wrb.685.1660663645984; Tue, 16
 Aug 2022 08:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220622003140.30365-1-pgwipeout@gmail.com> <88f2de00-32e3-ed74-082f-c0972a81f0f8@fivetechno.de>
 <CAMdYzYoTLjRW1FgwfizUu-+k0R4tCO78qYa7MEpgfz99aj3SvQ@mail.gmail.com> <ec3d2515-b2a2-8441-2e9a-a7fe664e048a@wolfvision.net>
In-Reply-To: <ec3d2515-b2a2-8441-2e9a-a7fe664e048a@wolfvision.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 16 Aug 2022 17:27:16 +0200
Message-ID: <CAMdYzYo1nm76ti3PCYk4DYtEnjWD731bybHaQV3ODBZi4SMvRg@mail.gmail.com>
Subject: Re: [BUG BISECT] phy: rockchip-inno-usb2: Sync initial otg state
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:20 AM Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi all,
>
> On 8/4/22 11:49, Peter Geis wrote:
> > On Tue, Aug 2, 2022 at 2:39 PM Markus Reichl <m.reichl@fivetechno.de> w=
rote:
> >>
> >> Hi,
> >>
> >> with linux-next-20220728 rk3399-roc-pc does not boot.
> >> Bisecting pointed to this commit.
> >> By reverting this commit the board boots again.
> >
> > Thank you for reporting this, someone was kind enough to reproduce the
> > problem on the rockpro64 and confirmed this is an issue. As I won't
> > have access to my hardware until next month, we should probably revert
> > this until the root cause can be identified.
>
> Just experienced this issue on my ROCK3 Model A board (RK3568) and
> reverting this commit solved it.
>
> Having the revert in v6.0-rc2 would be great -- if there is anything I
> can help to accelerate this please let me know.

If this is now happening on rk356x where I know it works, it now
cements my theory that it's a symptom and not the actual problem.
Possibly a race condition with the grf and regmap code where it isn't
quite ready when called. This code path is called exactly the same way
later on when the irq fires.

What config are you based on? I'm running a stripped down version of
the arm64_defconfig, but if you deviate from that it will be helpful
in reproducing the issue.

We should revert it until it's isolated, as well as the patch setting
the rk356x to otg since it will again be broken. If someone could
weigh in here as well (I currently don't have access to my hardware)
it would be helpful.

>
> Thanks and best regards,
> Michael
>
> >
> > Very Respectfully,
> > Peter Geis
> >
> >>
> >> [    2.398700] Unable to handle kernel NULL pointer dereference at vir=
tual address
> >> 0000000000000008
> >> [    2.399517] Mem abort info:
> >> [    2.399772]   ESR =3D 0x0000000096000004
> >> [    2.400114]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >> [    2.400594]   SET =3D 0, FnV =3D 0
> >> [    2.400873]   EA =3D 0, S1PTW =3D 0
> >> [    2.401161]   FSC =3D 0x04: level 0 translation fault
> >> [    2.401602] Data abort info:
> >> [    2.401864]   ISV =3D 0, ISS =3D 0x00000004
> >> [    2.402212]   CM =3D 0, WnR =3D 0
> >> [    2.402484] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000000137=
6000
> >> [    2.403071] [0000000000000008] pgd=3D0000000000000000, p4d=3D000000=
0000000000
> >> [    2.403687] Internal error: Oops: 96000004 [#1] SMP
> >> [    2.404130] Modules linked in: ip_tables x_tables ipv6 xhci_plat_hc=
d xhci_hcd
> >> dwc3 rockchipdrm drm_cma_helper analogix_dp dw_hdmi realtek drm_displa=
y_helper
> >> dwc3_of_simple dw_mipi_dsi ehci_platform ohci_platform ohci_hcd ehci_h=
cd
> >> drm_kms_helper dwmac_rk syscopyarea sysfillrect stmmac_platform sysimg=
blt
> >> fb_sys_fops usbcore stmmac pcs_xpcs drm phylink drm_panel_orientation_=
quirks
> >> [    2.407155] CPU: 4 PID: 71 Comm: kworker/4:6 Not tainted
> >> 5.19.0-rc8-next-20220728 #437
> >> [    2.407868] Hardware name: Firefly ROC-RK3399-PC Mezzanine Board (D=
T)
> >> [    2.408448] Workqueue: events rockchip_usb2phy_otg_sm_work
> >> [    2.408958] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS B=
TYPE=3D--)
> >> [    2.411634] pc : rockchip_usb2phy_otg_sm_work+0x50/0x330
> >> [    2.414332] lr : process_one_work+0x1d8/0x380
> >> [    2.416948] sp : ffff800009373d60
> >> [    2.419406] x29: ffff800009373d60 x28: 0000000000000000 x27: 000000=
0000000000
> >> [    2.422199] x26: ffff0000f779fcb8 x25: ffff0000f77a3a05 x24: 000000=
000000000c
> >> [    2.424978] x23: 0000000000000000 x22: ffff0000010c8258 x21: ffff80=
000888ec10
> >> [    2.427768] x20: ffff0000010c82f0 x19: 000000000000000c x18: 000000=
0000000001
> >> [    2.430604] x17: 000000040044ffff x16: 00400034b5503510 x15: 000000=
0000000000
> >> [    2.433390] x14: ffff000000708000 x13: ffff8000eec96000 x12: 000000=
0034d4d91d
> >> [    2.436185] x11: 0000000000000000 x10: 0000000000000a10 x9 : ffff00=
0001aa7a74
> >> [    2.438958] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffff00=
0001aa7a74
> >> [    2.441668] x5 : 000073746e657665 x4 : 000000000000002f x3 : ffff00=
000356c808
> >> [    2.444407] x2 : ffff800009373da4 x1 : 000000000000e2ac x0 : ffff80=
000888eb34
> >> [    2.447190] Call trace:
> >> [    2.449557]  rockchip_usb2phy_otg_sm_work+0x50/0x330
> >> [    2.452169]  process_one_work+0x1d8/0x380
> >> [    2.454684]  worker_thread+0x170/0x4e0
> >> [    2.457056]  kthread+0xd8/0xdc
> >> [    2.459354]  ret_from_fork+0x10/0x20
> >> [    2.461728] Code: 91037015 295be001 f9403c77 b940e413 (f94006e0)
> >> [    2.464338] ---[ end trace 0000000000000000 ]---
> >>
> >> Am 22.06.22 um 02:31 schrieb Peter Geis:
> >>> The initial otg state for the phy defaults to device mode. The actual
> >>> state isn't detected until an ID IRQ fires. Fix this by syncing the I=
D
> >>> state during initialization.
> >>>
> >>> Fixes: 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
> >>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> >>> ---
> >>>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++++
> >>>   1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/=
phy/rockchip/phy-rockchip-inno-usb2.c
> >>> index 6711659f727c..6e44069617df 100644
> >>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> >>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> >>> @@ -1162,6 +1162,12 @@ static int rockchip_usb2phy_otg_port_init(stru=
ct rockchip_usb2phy *rphy,
> >>>                                       EXTCON_USB_HOST, &rport->event_=
nb);
> >>>               if (ret)
> >>>                       dev_err(rphy->dev, "register USB HOST notifier =
failed\n");
> >>> +
> >>> +             if (!of_property_read_bool(rphy->dev->of_node, "extcon"=
)) {
> >>> +                     /* do initial sync of usb state */
> >>> +                     ret =3D property_enabled(rphy->grf, &rport->por=
t_cfg->utmi_id);
> >>> +                     extcon_set_state_sync(rphy->edev, EXTCON_USB_HO=
ST, !ret);
> >>> +             }
> >>>       }
> >>>
> >>>   out:
> >>
> >> Gru=C3=9F,
> >> --
> >> Markus Reichl
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
