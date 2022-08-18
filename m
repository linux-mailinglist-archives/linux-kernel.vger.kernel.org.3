Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C01597EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243792AbiHRHFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243789AbiHRHFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:05:51 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E858709E;
        Thu, 18 Aug 2022 00:05:50 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id v128so623165vsb.10;
        Thu, 18 Aug 2022 00:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=a+e+QGhn5sn3V7lUKOzpCWb+9pj3d5N7fTGM2cOhh+s=;
        b=QODEiGDu9p0FTrpyiABxU991BdJBWJE6MEs4yngJOvDM8mFSLvsM1NWLXQOHJiDQIZ
         3IyrYORBDWFDHi3WTZpY1mWH7s31gyxzupk4GHE5zgS0MnB6XJMBrhdY1MNEShjopoWv
         qRKOhLYKc2vvZoPXu+dCCJTIsboWwEmH0S2kAi6Ml6+7JitFCXniYbLO3TGc87lxen0k
         4ieh81NWgCDJ5rg7PxDrRmwB9TC+iiZsycaF2an30reNzWoV2GdDyNgkvo0a9x3bWQZ1
         9Eqgz3vLAIWcfMkrAW7U04NiZ9ao9R1ZDKc5PbA8cnFU9rjMzY4+lfmyTkuOoQ9mcZsD
         5q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=a+e+QGhn5sn3V7lUKOzpCWb+9pj3d5N7fTGM2cOhh+s=;
        b=D10bPwqGQopSd0bkVTHnOSjp8Idh4J3PVYq0raUTlmHbJGPtZDt3u+Mcxj0q0iMzeD
         5jL3nTjfuqlVfhHtOpLkVABBFbbaYJPSQEgcPqzEuhTvqc6AIlLzvTXUgekKDZeKdH8x
         sBPI1JfX0v/IIyn01/vMV+o8itjdPW1AGdczUbtq1btDok63lFXwk5QkWFUL7Fsbt040
         XE7Y5LZVV6GrBYXedIaAgB74IWRcDasF2EEaLJKx5NbA8KKRkb+NTW3wTjQ3BJSBGwlk
         45KAFw3HIOhIjdm00ERxfm3Q4VSaj+hmB62u+G1KLBRwoiqodY9fLCMxVhkzkm/z/PCE
         m8Sg==
X-Gm-Message-State: ACgBeo2SROyagr0hKq5KsA5viGuODHFccq29CfGSoeH3Ocls8CQ9cPcy
        M5yqBbNI9jny+J1xI1oN03MBmkYK2AFD91z0ug8=
X-Google-Smtp-Source: AA6agR7cE2a2nGxJ/dDd1AfoOz28N0RchW4jLMnj1h1J1ZEbueTzietm5V7RSX4C/+cS+pEWw0zzGxbAmu1XKGsWLpU=
X-Received: by 2002:a67:c014:0:b0:388:daaf:5029 with SMTP id
 v20-20020a67c014000000b00388daaf5029mr660423vsi.65.1660806349462; Thu, 18 Aug
 2022 00:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <1660787634-28550-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1660787634-28550-1-git-send-email-shengjiu.wang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 18 Aug 2022 10:05:33 +0300
Message-ID: <CAEnQRZA=df7xMGvDLD-vcz16hdQBWq2u2xWD=Mo5054wQNrmEw@mail.gmail.com>
Subject: Re: [Sound-open-firmware] [RESEND PATCH v2 1/2] dt-bindings: dsp:
 fsl: Add SOF compatile string for i.MX8ULP
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        shengjiu.wang@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org
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

On Thu, Aug 18, 2022 at 5:12 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> Add SOF compatile string "fsl,imx8ulp-dsp" for supporting DSP
> device on i.MX8ULP platform.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
