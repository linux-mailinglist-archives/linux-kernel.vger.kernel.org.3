Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9377B524934
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352132AbiELJiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352133AbiELJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:37:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04F26FD1A;
        Thu, 12 May 2022 02:37:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so7324951pju.2;
        Thu, 12 May 2022 02:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=iZFrk+1WuAX7Uovgz4zajtM6wW58xVr5fx7WagK6QTE=;
        b=iuLH0XfcHwUlF/vNb9nAe18b2ojIBUCTOjyojcLYaPl/T7OisuyAs147hvM1DKucIB
         DZ23cJSUA41Gsojj/ZqZ/X81uqu/i/NKlsjSWQgOuI6GSZ+bdoIkTlv8mAaeEv9ry0ci
         1bBnhdA4CY9RlEuOQXhhb7sgDR9VPA27HPvMuKu/JtntNi3sQmVAp384gNS+BmHiA/fs
         F+kXkG485qOdYmtwpta5IljifuUEMpVStwRG6QgEepeEez4mIlpv9mejVuKY1z/5cNm6
         T2F35aXq0/Dm/s+OCm0ufX/idfqkOWH8r/OeBNMYGKN/aa+SoBf9AE8BlwF6Xs2kuMNZ
         JJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=iZFrk+1WuAX7Uovgz4zajtM6wW58xVr5fx7WagK6QTE=;
        b=QJjMbdL0Y+jKWVwhMAHvGYf7r3qYUW01i23kPMa8jAGfZMt2Orn63K5BDhbHMPzRc5
         pwYOJBqzd4qTwoHciESAWzDEAlbjbPC1a1KHS6dOkM8u1tBawkQlHPKgy1kMahw5rTO0
         t3zFS15W0kRVcvHlXqYkEuv0sLPmWSx1/TC62qVO2Oam/Kb33FkBHgQhnjLt7AAMASDG
         RcrxeGmTXqPxQUbbQvHSAOiKJqNsUDORG8O0jyvFnEaJnGFl0K1GaDRLv8aVBoI8nvAQ
         3dWA1oIqgEEh3ncLwFJM3K6LBVU824UWANllCF1zr6MJqNOvqV+hFdnnq/nAh70w5hrB
         AeeA==
X-Gm-Message-State: AOAM530+0nJcWdqbVVWljaXjngK4klVkDLAuodbkybLixv/rWuL0qoky
        E48wQiW2U0LiqTfyRqRrRSQ=
X-Google-Smtp-Source: ABdhPJzQfordeKPqWJc5pKiQnLmj2Bbc9ov9S+FxXYv9EgRzW0ywBuhOTZVWRfnZoW1+3gLBwaTWzQ==
X-Received: by 2002:a17:903:32d0:b0:15e:8cbc:fd39 with SMTP id i16-20020a17090332d000b0015e8cbcfd39mr30500975plr.95.1652348258335;
        Thu, 12 May 2022 02:37:38 -0700 (PDT)
Received: from localhost ([49.204.239.218])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b0015e8d4eb2acsm3364350pls.246.2022.05.12.02.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 02:37:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 May 2022 15:07:32 +0530
Message-Id: <CJXOKK6WT06F.109YU66ZCBP5T@skynet-linux>
Cc:     <bjorn.andersson@linaro.org>, "Andy Gross" <agross@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8916: Fix typo in pronto
 remoteproc node
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
X-Mailer: aerc 0.9.0
References: <20220510042654.71152-1-sireeshkodali1@gmail.com>
 <20220510042654.71152-3-sireeshkodali1@gmail.com>
 <81365629-6cf0-f320-e684-4fb40b829399@linaro.org>
In-Reply-To: <81365629-6cf0-f320-e684-4fb40b829399@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 11, 2022 at 11:41 PM IST, Krzysztof Kozlowski wrote:
> On 10/05/2022 06:26, Sireesh Kodali wrote:
> > The smem-state properties for the pronto node were incorrectly labelled=
,
> > reading `qcom,state*` rather than `qcom,smem-state*`. Fix that, allowin=
g
> > the stop state to be used.
> >=20
> > Fixes: 88106096cbf8 ("ARM: dts: msm8916: Add and enable wcnss node")
> >=20
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
>
> No blank lines between tags, please.
>
> Best regards,
> Krzysztof

Will fix in v2

Thanks,
Sireesh
