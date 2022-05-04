Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5071551B147
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378841AbiEDVqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378860AbiEDVps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:45:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D006852E6C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:42:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x18so2636518plg.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+YytypHoUck4k/sP0+tgNCidzpN+9CPPoe6T3TFQ1ss=;
        b=c5GaFHza5u7zvdhOsEfhBT8PmFAesf08tJm5iWhYA+F0yZQ9vDP8vxKMLFYa6NnPzh
         U5uaW9BK/DNMrVOepxnE8CoG/xtF2ssSkDb06AcMsTY/s7v/rojWhl3cdJ4EzppKskx1
         upJLj3rUatHbTs9zo76ExUqufrCRUCKEJL48A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+YytypHoUck4k/sP0+tgNCidzpN+9CPPoe6T3TFQ1ss=;
        b=1oMIzOlYt4JVSinoPAe76xdtVOs+kHq1Saorv41jz+lDGVTHg010ctzOY1DSMtGxcM
         yxjfFIjXpCEP6s+C7D1480d/LNLIras9dIcgqW5GOSMobpEF0YSAVzm8KRM5M6waTeCt
         39PdVV1FgHmcwZ25izJI8/I6ZheJa5BhfMtUB5LBR1+pxmok+/osNhbvBsv/2Hj9u3/L
         Yk3sYDPm7E6rHz2FVnIYMFUvg+dOE9XkLpQswO0n7ehk1/hqxc0pOAAaaY0fGtz9TBjL
         pb8yRRMqJnyO6+M7e2mCQ0H21j3VYofQp49uwguMq/DEpMW6ARwHSmQ3GbbdRqmOyqgw
         Lk7w==
X-Gm-Message-State: AOAM533+OWVLYaf5ZPklWBVD58R7sEVlbpSwrEc7Qkf72MW7Qv7nkyKw
        X2cR+UCY3F3QBjrAucwlvVQbXQ==
X-Google-Smtp-Source: ABdhPJxmYyfqjb6wWssNObgtiUEn8/QazbGRnP+SJH4zsggo4uV6Hby443ibWAm2p7zM7LveboiQVw==
X-Received: by 2002:a17:903:11c7:b0:151:9769:3505 with SMTP id q7-20020a17090311c700b0015197693505mr23612341plh.72.1651700530415;
        Wed, 04 May 2022 14:42:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:35b6:c77b:be04:3bd5])
        by smtp.gmail.com with UTF8SMTPSA id k2-20020aa78202000000b0050dc762816esm8638181pfi.72.2022.05.04.14.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 14:42:09 -0700 (PDT)
Date:   Wed, 4 May 2022 14:42:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v11 11/12] arm64: dts: qcom: sc7280: Add sound node for
 CRD 1.0/2.0 and IDP boards
Message-ID: <YnLzMIt0bnzsSeq9@google.com>
References: <1651664649-25290-1-git-send-email-quic_srivasam@quicinc.com>
 <1651664649-25290-12-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1651664649-25290-12-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:14:08PM +0530, Srinivasa Rao Mandadapu wrote:
> Add dt nodes for sound card support on revision 3, 4
> (aka CRD 1.0 and 2.0) and IDP boards, which is using WCD9385 headset
> playback, capture, I2S speaker playback and DMICs via VA macro.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Carrying over from v10:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
