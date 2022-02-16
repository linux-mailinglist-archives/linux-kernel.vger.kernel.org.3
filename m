Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4896A4B9197
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbiBPTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:43:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbiBPTnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:43:24 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5BE10EC79;
        Wed, 16 Feb 2022 11:43:11 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s8so1108606oij.13;
        Wed, 16 Feb 2022 11:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YRJGbnQOnF/oKC/Tjrr2Q557LB8S7RqNy7bp3q/iBfg=;
        b=KZ6CnaXRPn6Z7VhyaKnulEjmm28Zl2DvsraVGtQuJI3AiJcmDkG7M9TEOoZxeM+UZd
         AeHUtuZRNLxskJusd62C2/6G5iUhUv0ZAEBKJO+7ZuAjM0VFPsD9gcK8q6gbEuaR8rQv
         ucIKL3m0su2DSNYw7/UR0q/stpA1TZiCczQ/p235JuI7hEMCd/wITBjs+FOVOAkvcCJY
         DQJSxVZvgZxh72UNFbIxoPvIzJUS7/sKWKaY637vYKdqfsnepdz1sjgyH2ZNuGWTouM3
         C+8MK6VCblShpQo91FkPd5LKQN/mCkq69UEdDOo2Z1pbSfqwOBnidQKNyELANqIcTPOM
         Hzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=YRJGbnQOnF/oKC/Tjrr2Q557LB8S7RqNy7bp3q/iBfg=;
        b=LVdq2YnAyRlnUm9QLQ5IWEuVBBJIwOKCPW6/1E0VD7Nu+aNz6SBJHkhvTUA3VlRo6f
         zBa8nK7++TH92LSDdJQxQWE/mdbmQvBteu30pvXzB/h7vsxPySlWUxpgzuV2obyUDb2o
         PyXOmfBDu3AL/0rqXtGdPpJCs4P+wyXl4nfHmFWzcbfvxup0eEDgB2PoqusmGp+muNHr
         rUcAhnLLvrIibjgU9agQ9Ti5prj5zupADj3JchBub/k0M0lQbLooXwhRqHDDsnfbUmSd
         5iFAM+wjbNSGf3O/yxzQNhxcsi0avdY/NtcpcuLdrdjojcdoZhhe8FxycObDzvaRAY+Z
         DziQ==
X-Gm-Message-State: AOAM533zuJjNB0HUb5uJsxKLXRjZ100ELR1PZK7s4S/6qL32StNE9l49
        shzHkWhYh2OGPUbsmAha8J4=
X-Google-Smtp-Source: ABdhPJwt5sGVFldwt2GeJO9d8EV7kExjWNn6LfVm8qj6OcnflospbFuhYKK3OGjwHSOSZja70wiG6A==
X-Received: by 2002:a05:6808:308d:b0:2c8:feb5:9cc7 with SMTP id bl13-20020a056808308d00b002c8feb59cc7mr1446934oib.139.1645040591100;
        Wed, 16 Feb 2022 11:43:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i26sm7669257oos.35.2022.02.16.11.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:43:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Feb 2022 11:43:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] hwmon: (asus-ec-sensors) merge setup functions
Message-ID: <20220216194308.GA3307305@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 08:19:58PM +0100, Eugene Shalygin wrote:
> Merge configure_sensor_setup() into probe().
> 
> Changes:
>  - v2: add local struct device *dev = &pdev->dev;
>  - v3: initialize dev at declaration
>  - v4: fix checkpatch warning
>  - v5: fix formatting
>  - v6: code style fixes
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
