Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0C056C241
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbiGHUtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiGHUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:49:01 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108A984EEC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:48:57 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id s16-20020a0568301c7000b0061c283d6c37so2042374otg.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=oTRkIHkkNvP0E53VWhSF2X9Yi/sOj2WBCOpKZoAXIu4=;
        b=MigDeIBYToCrLnSVXo5wEsyN9vgrb0Ai7tzQl4JjezdR+NsMxylX2bslPxBhO0L7Et
         xCQgyTmwveugyEZZjMmKFU8pf/H24ibg8B+tLycbqfl9QO9ThpmxTN2evdRLrl56SbYk
         olrNkSc8UA/V+PnmX2eZNcnBPx+qYIs+ldTW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=oTRkIHkkNvP0E53VWhSF2X9Yi/sOj2WBCOpKZoAXIu4=;
        b=DDaAqxNxuEpWb1vs+plHlMIf7wiZ+/P2vr5L4/O8s6xA0DKv0D9ylk0P3QAbn0A8WF
         ND0zuZEa5JURZSMdYTpyhDLw2U4J5c95F9ioejVlki/h2SEuGTuhY6qYPXVDDiH7P162
         X5+PEK0U2WVdNpzxOwjW6J2nKITKRlWwQr/l+pwVSANYIZnMHftRQ4vm26J5SbGNfNGU
         vJrqGD0sGhUQjI0H52R2XSgPYc6O0ne1vZY6vk9YmDN1jzQWknQep43K5g3XnhMEN2+a
         TdTGTSLEvXT7jzpc6af1Y77OMTq2cuRFMYFBRkDZwzoZX7JWBRCg0yfmj/Qcr3gSsbgq
         olqw==
X-Gm-Message-State: AJIora9lzgo2bsGdYm/zlN8zVG0ickwAaWs4rHKTw2EkUJ3Sbn3wEcr6
        Zfs4bgC4XMXQeE4EZhN7DpFLD2SDhYm6EePh1NVPZA==
X-Google-Smtp-Source: AGRyM1taOliA1drxAbyZku2NYLmp4/EsK31dn6TQJuxKde3Uv1L7lNEiCnBSek/bIMbxUbcnOmOzWSA8kvZdIxxCJv4=
X-Received: by 2002:a05:6830:d81:b0:616:c424:6f22 with SMTP id
 bv1-20020a0568300d8100b00616c4246f22mr2394204otb.77.1657313336409; Fri, 08
 Jul 2022 13:48:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Jul 2022 13:48:55 -0700
MIME-Version: 1.0
In-Reply-To: <ac679a45-9574-7978-860f-1a1bcefb53ec@quicinc.com>
References: <20220614161118.12458-1-quic_tdas@quicinc.com> <Yqi8rcs95CEEjGY4@google.com>
 <CAE-0n50cqBWpDKsiyDNMZ8GnNtj7xJn930S1hucdAGn7tGXewA@mail.gmail.com> <ac679a45-9574-7978-860f-1a1bcefb53ec@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 8 Jul 2022 13:48:55 -0700
Message-ID: <CAE-0n51vx8X3+WiOSMx9LnO17uu+5XapYjSG8ybKOS_F_CYAhQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Update lpassaudio clock
 controller for resets
To:     Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-07-07 00:06:59)
>
> Hi Stephen,
>
> On 6/15/2022 2:08 AM, Stephen Boyd wrote:
> > Quoting Matthias Kaehlcke (2022-06-14 09:51:57)
> >> On Tue, Jun 14, 2022 at 09:41:18PM +0530, Taniya Das wrote:
> >>> The lpass audio supports TX/RX/WSA block resets. The LPASS PIL clock
> >>> driver is not supported and mark it disabled. Also to keep consistency
> >>> update lpasscore to lpass_core.
> >>
> >> There is a driver for "qcom,sc7280-lpasscc", what does it mean that is
> >> isn't supported?
> >>
> >> IIUC one problem is that 'lpasscc@3000000' and 'lpass_aon / clock-controller@3380000'
> >> have overlapping register ranges, so they can't be used together.
> >>
> >> You could just say 'Disable the LPASS PIL clock by default, boards
> >> can enable it if needed'.
> >
> > For the pinctrl driver we added a "qcom,adsp-bypass-mode" property[1] to
> > indicate that the ADSP was being bypassed or not. Can we do the same
> > here and combine the device nodes that have overlapping reg properties?
> >
> > [1] https://lore.kernel.org/r/1654921357-16400-2-git-send-email-quic_srivasam@quicinc.com
>
> Could we take up as a cleanup and take it forward:
> https://lore.kernel.org/lkml/20220614153306.29339-1-quic_tdas@quicinc.com/T/#t
>

I don't think so. The binding would need to change.
