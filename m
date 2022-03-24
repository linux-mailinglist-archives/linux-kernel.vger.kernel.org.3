Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EFD4E62B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349875AbiCXLyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241266AbiCXLyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:54:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB969BAD8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:52:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so4894104pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aroiU2GiEBc0mzOQ/Loh3g/ALUh7v+xPixNkYKzQpTk=;
        b=i8rXTdMYXmqBOuF5RneRqV2feGsnqlp8h0N3j3r4lUrvshXAuvGWrvuAKYOzhiMa+B
         jnDWZ+xQ8nsAIc88UF1cb18QpmJ26NBlQfAm5PHFgrsEuL++TBJnL32ZOHtn0FokAsAQ
         NM2qAbSFbqn4BFjvM1pZ/NQbxCGfEoE0dAMzJIoNAmtkUe76WsNR/IZKtERD4JJDz4H8
         mPQ/8oAs+HQKGcAWbgcW/+DvJAXUpdYhhL9eOsnUp0I41kT/rsLUJ3UO63LCHMSRQafZ
         h8Ebu+oqnFmowoDM4/JqYzTYeqXImbbExAUY3bEsEbt4EmXmlCPtV30wvZ3D72QJVWPb
         c8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aroiU2GiEBc0mzOQ/Loh3g/ALUh7v+xPixNkYKzQpTk=;
        b=7ELuFnatcK/D9A8I84AfvfQH3SuDHhnltYOWCluZjKR8UJuXHxulxrmwxtU11vA20H
         KvpF77f2NXGLAlimLNB7VcE3jR7nrzUCc6w6dzHQTUa6aamy15SUVMyqU7FjZq6igWY0
         epuBf+WDuVwyhFJxlvp3yTHk2wvkerexpSo4wwP/mKX920VjJnLXv0l9IH+MGzzElryY
         XVhiWO+ti5//iWYDhZKro7HyxTUB8jQP7LNZUJl7N7G1l2/8kZpn2ylengoP4ZcmR806
         jxOxXPawQcjcx2HP8qfQ6e7Lva6GE3N5pjPy1BPm9U3xkUNtjeNiyTWtkrMHZEE/3F2z
         2REw==
X-Gm-Message-State: AOAM531hWBMhxPNJc3Y1C05sfZdmHh+aePskIIMNHWa6Ufs/83YoLXIP
        ++EIjictUl/22Yl5ISmTcAnrpnrP3mcyF07KM67vTw==
X-Google-Smtp-Source: ABdhPJzXKDj3d1FS7qaSZQA8ljtBwjUrx0yl4r1DjZ+msZR2HsfW4E4dfXE2mgixdUQOD8MK3sWX3uSB8iWC5oP0iVg=
X-Received: by 2002:a17:902:9301:b0:153:2252:44ea with SMTP id
 bc1-20020a170902930100b00153225244eamr5350911plb.65.1648122748899; Thu, 24
 Mar 2022 04:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220317094724.25972-1-yuehaibing@huawei.com> <CAG3jFythpVSh-CLuBAu8AC403Yq7Sh-oAjjkPtA+JFuN7_OriA@mail.gmail.com>
 <4d20ab47-6871-3ca5-2751-a2499166cada@huawei.com>
In-Reply-To: <4d20ab47-6871-3ca5-2751-a2499166cada@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 24 Mar 2022 12:52:18 +0100
Message-ID: <CAG3jFyu1VrzNE0GyB9+tr_eBZd_83eTgSqv1NpdeZASrn_xnhg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/bridge: it6505: Fix build error
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        Hermes.Wu@ite.com.tw, allen.chen@ite.com.tw,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added r-b & applied to drm-misc-next.
