Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DAF531DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiEWVaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiEWVaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:30:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595FAA3381;
        Mon, 23 May 2022 14:30:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p19so1092113wmg.2;
        Mon, 23 May 2022 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szpHbyssy3pR92tHPw2c+r7gOFG688ltDB8dep/mxSw=;
        b=O+1anRyYFBUQoaX7dUDxSVnoc5f4zDJd+/tIByNkeoinJxa5tIeVZZpelKrE0FqoNo
         OZgOVS31HeCzlfDb7tpu0Be1eVBZxWJPzx7RfH2OCO73s9WyPFwuoXtDGVVoB8AMb2Yi
         56M5xUiEf1zCzMnZcBzNT/4cAh1b1CeRF9ah6nVWB8X/UOoWIpJcAXgmi0Ha7udrcy1j
         699DxcjWIUoATgdE/um3C9/U7wZz6TNAULxRaQoR+jxSfvrh4tyY1twMsgEek7fEEaHk
         HQ8GOPxI6lv0JPF2hHhzzGpJBDsmH9exbxIWte78wVwxrA5y9b0RzzUaWBtwFS3VzxCJ
         lCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szpHbyssy3pR92tHPw2c+r7gOFG688ltDB8dep/mxSw=;
        b=cqcrjN9hT293kJKNVS0KxOZFoxK6DVxpXCAWMIPwnPjxefaDddMYSNZC15CKM5NGZX
         amlqvKnSxHH5vCyToXyR7Pez6LC/AZLsM99g+LJ6Hduqfz6d7xYiLuMbxiunsD/dIvv7
         oTUGN/efGLdIVTETd/tbkvJRmEPvNPBd64f+CkRrDjfRD1UG1jfu5mw4DgCyLWRh9Q48
         huN4Ry4auEnJseWJlkRrBlKHRc/IK9P0OKDYcvKRBLhYDt8PHOkbYEj430FtWa6Dbhgs
         XP4O/J/fsLjX8drwJcL/pJIHtxJxCU2BvO8i7R18epoAmGQzobeLsws+GiX4GcnaBbsL
         wGqg==
X-Gm-Message-State: AOAM533dI2z9TsvVL8R7JetZNFOBaeDB7M8CcAFyVwj7YslBwoTxnIE1
        NIRsXPfH/YmQ7HEYc+KZI6chbMT5G8/xIqaZkbDQmno0
X-Google-Smtp-Source: ABdhPJxeVgPf7mVaaoeUZX7Sv2I4aDpFJhfiYqkaHPVJOp3ofkBKRrCA81w/4FTYvTcWJlq3mZoJGSG6A79jb7vL0zU=
X-Received: by 2002:a05:600c:3843:b0:397:476f:ceb8 with SMTP id
 s3-20020a05600c384300b00397476fceb8mr860129wmr.200.1653341402568; Mon, 23 May
 2022 14:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <20220522195138.35943-1-konrad.dybcio@somainline.org> <53d5999b-88ee-24db-fd08-ff9406e2b7b7@linaro.org>
In-Reply-To: <53d5999b-88ee-24db-fd08-ff9406e2b7b7@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 23 May 2022 14:29:50 -0700
Message-ID: <CAF6AEGuX9eL8DmBqRj79F3Z9QCAczZDA+Xz-t9CjKQ5+6Phtrw@mail.gmail.com>
Subject: Re: Removal of qcom,board-id and qcom,msm-id
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 1:21 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/05/2022 21:51, Konrad Dybcio wrote:
> > Hi,
> >
> > removing these properties will not bring almost any benefit (other than making
> > some checks happy any saving some <200 LoC) and will make the lives of almost
> > all people doing independent development for linux-on-msm harder. There are
> > almost unironically like 3 people outside Linaro and QUIC who have
> > non-vendor-fused development boards AND the sources to rebuild the
> > bootloader on their own. Making it harder to boot is only going to
> > discourage people from developing on these devices, which is already not
> > that pleasant, especially with newer platforms where you have to fight with
> > the oh-so-bright ideas of Android boot chain..
> >
> > This only concerns devices released before sm8350, as the new ones will not
> > even boot with these properties present (or at least SONY Sagami, but I
> > doubt it's an isolated case), so other than completing support for older
> > devices, it won't be an issue going forward, anyway. But there are give
> > or take 50 locked down devices in mainline right now, and many more waiting
> > to be upstreamed in various downstream close-to-mainline trees that should
> > not be disregarded just because Qualcomm is far from the best at making
> > their BSP software stack clean.
>
> I actually wonder why do you need these properties for community work on
> such boards? You ship kernel with one concatenated DTB and the
> bootloader does not need the board-id/msm-id fields, doesn't it?
>
> Not mentioning that in the past bootloader was actually not using these
> properties at all, because it was the dtbTool who was parsing them. So
> in any case either your device works fine without these properties or
> you have to use dtbTool, right?
>
> >
> > One solution is to chainload another, (n+1)-stage bootloader, but this is
> > not ideal, as:
> >
> > 1) the stock bootloader can boot Linux just fine on most devices (except
> > for single exceptions, where beloved OEMs didn't implement arm64 booting or
> > something)
> >
> > 2) the boot chain on MSM is already 3- or 4- stage and adding to that will
> > only create an unnecessary mess
> >
> > 3) the job of kernel people is not to break userspace. If the
> > device can not even exit bootloader after a kernel upgrade, it's a big
> > failure.
>
> The job of kernel people is to follow bindings and since they were
> introduced 7 years ago, I would say there was plenty of time for that.

Then we should document these fields to reflect reality, rather than
remove them.  The kernel isn't the only consumer of dtb ;-)

> If the dtbTool support for the bindings is there, then there is no
> breakage, because you had to use dtbTool before so you have to use now.

I don't believe this was the case?  At any rate, why are we trying so
hard to make our lives harder?  Let's just acknowledge reality
(bootloader uses these fields), document it, and move on with life

BR,
-R

> >
> > If you *really really really* want these either gone or documented, we can
> > for example use them in the SOCID driver, read the values from DTB and
> > compare against what SMEM has to say and for example print a warning when
> > there are inconsistencies or use it as a fallback when it fails for any
> > reason, such as using a newer SoC on an older kernel, without updates
> > for SOCID read (which are sometimes necessary, which was the case for 8450
> > recently, iirc).
> >
> > My stance is to just leave them as is, as moving them anywhere, or removing
> > them at all will cause unnecessary mess and waste time that could have been
> > spent on more glaring issues..
> >
> > Konrad
>
>
> Best regards,
> Krzysztof
