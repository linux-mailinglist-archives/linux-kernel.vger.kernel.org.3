Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA23C510AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355301AbiDZVGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355241AbiDZVFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:05:52 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C042C4C7A7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:02:36 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id f2-20020a4a8f42000000b0035e74942d42so10384ool.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=qEtkFZetJ9a17spXA9ebo0ZoaMU6GomnRunLZuYIOzU=;
        b=ejvOCooKk+1oqQfD3u3HSZmGlPCV7W/7UHbOQUFeBT9ekTYMsnuXtulu2IPWAAP6W6
         Ncjxa60Mq+Sw8k16LWMCIzE+jGgAY/4Z8elCvJPiqEEq+saLPXJ43EMVEvN+DaMCJAxY
         8uRRMBpjBXa/7K8PpMQHfgHbxmVg6vxOog1KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=qEtkFZetJ9a17spXA9ebo0ZoaMU6GomnRunLZuYIOzU=;
        b=R5/vAF5vROaDIWbhhbbN1+pYG5Ou1/R9QiEyM9fLW4lyzwoOTjg4OfoSZwbYWcvcqJ
         aQ2cznSWU+sJjZprLISH0oVd4208zgvH9qO0LtZu7psctSgCyN/5CmzEoLoMKMyML6zL
         luJud/x1rmHCduUMuCWXyCFE5eAHtUGMl3Udfw8qG9N4Rs1Gi5xd7XKHQj9e3ThOdBxb
         ScUaNqshI8h4J8kWfWS4W6qTnrltLggb5d828xiQXmxtD+NuDv309af01tfs/XnbU6+z
         mVbk4dXmyD0OeNVQAndBddFMsP1+gQy8UW3DTZDV3SsCE1Jo8bMhn3c4q3W8cMKiOX7R
         oIrw==
X-Gm-Message-State: AOAM530nseFiFQd2qEa17diEUFDfdZbwrvYHN7Zzywajji6V/RWL/Ybn
        KcQ0w9J91AYXIrYo+Vq7O858ZfTrywY816Hqh9tAuQ==
X-Google-Smtp-Source: ABdhPJyX2tt94IZxxiwugK18OZhd/mYokzmjPf3b8ISvStP3OxlWQq6CasrPDDXe+J9Il7UXag8gxagXYu8XR+2uZ8Y=
X-Received: by 2002:a4a:6b49:0:b0:329:99cd:4fb8 with SMTP id
 h9-20020a4a6b49000000b0032999cd4fb8mr8908758oof.25.1651006956146; Tue, 26 Apr
 2022 14:02:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Apr 2022 14:02:35 -0700
MIME-Version: 1.0
In-Reply-To: <DM8PR02MB81025CD159F1B2158EAE979CF0F49@DM8PR02MB8102.namprd02.prod.outlook.com>
References: <20220202053207.14256-1-tdas@codeaurora.org> <CAE-0n52T9Z+LS3KMVeSBsad=Em3e27J=rEzHTB0WS-b5M=owFQ@mail.gmail.com>
 <DM8PR02MB81025CD159F1B2158EAE979CF0F49@DM8PR02MB8102.namprd02.prod.outlook.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 26 Apr 2022 14:02:35 -0700
Message-ID: <CAE-0n50nsMOqekDqrg+n0A8mP9BVS10DEbMqDSESyHTD4sSQVA@mail.gmail.com>
Subject: RE: [PATCH v3] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
To:     Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, bjorn.andersson@linaro.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (QUIC) (2022-04-21 10:40:28)
>
> [Taniya Das] Sure, I can remove the node which should be the cleaner way.

If the node is removed then the driver should be removed as well? Did
you send a patch to do this?
