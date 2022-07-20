Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFA257B642
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiGTMWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGTMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:21:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AA2459AA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:21:57 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 19so20941209ljz.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=czpwbxCojRRusw6HWu6t/8/63T8r2daP9XhqstNyWjk=;
        b=auK+eK6PVjKmPBaAqEenWTMcrcU9JbnofAZN0uyqSf2puV6NPWZUBZNL3k79dRsS/o
         hvbRGWrexApWqVgYqKx396U/pigDIHLP8ngbKiungbugJoHtL3dgtngWDdojDWRaeWn2
         hoKUjKhtzvpIsbkUrezRI2orSAg1+tD3H1J7kNhxJYuZLt6gBeKfXc/ugZQTDv0PwrqV
         T+uHpDZ1rTrE2cfvvLdy2HkQNPhsUGEVXyHHSqk8U56NCnjCKNuaITTcO4XzU6D+GVRC
         goalaRtZpjNrM2VDTRolfr6+Bpy/7ge9Eos0hgnL5TTCtXindu1b2Bn3zC2wrjuGnKVS
         pCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=czpwbxCojRRusw6HWu6t/8/63T8r2daP9XhqstNyWjk=;
        b=wzFKcIPVKjcZtBJk8wZCwHywNQddzzuoH6x3sZ4XL/gVyzTKDc26WQpBopTyi9yLdt
         lYr0EHbTHdpMeRJIsxfRr6tUdEc2LMEpP4gfyz/0vKpU78QNqouxJ1/7WTRvnp4WAB37
         zMFNkNhRkSMJ69Z16EPirWsZ/qK4+SUIAik15Aax7COu8Yq+smgnM35PbKk1BWAcICKK
         CW0xIWa2/wZ5m+NTvZ9EIIX84BpQwJtXXVM00YQlWm3zNtJN5n3Q9mCpGszpXstigOZM
         Vt4yhMJRzJB+Ft8yc4olLm6/y3PB6lYsZyBLH+tEpSX0CUpB92COTZoj8Kt7PXr5R+fM
         Eh+w==
X-Gm-Message-State: AJIora/LoF4MC6ydVmAJZPqTPwEB65bv/Cnyv6fwtvMMxMHlOY9du/qx
        rTG2Z1+jIW0oJTx4MF6yal2Pm5yu6zgIC7Gt
X-Google-Smtp-Source: AGRyM1s3DxlIhQ64eu+g38+2iFSkaJ0qaJ4gAr+xFlOX31BEZkhO0H6TKdg6l1zPJKqbCm0NeQ3S6Q==
X-Received: by 2002:a05:651c:a0e:b0:25d:a7b9:762f with SMTP id k14-20020a05651c0a0e00b0025da7b9762fmr11004224ljq.458.1658319716162;
        Wed, 20 Jul 2022 05:21:56 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512200c00b00489e38c4fc4sm3777242lfb.276.2022.07.20.05.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 05:21:55 -0700 (PDT)
Message-ID: <b2c4f548-449a-8855-fe68-005566711cae@linaro.org>
Date:   Wed, 20 Jul 2022 14:21:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] dt-bindings: misc: tmr-inject: Add device-tree
 binding for TMR Inject
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     appanad@amd.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com, git@xilinx.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
 <20220720060016.1646317-4-appana.durga.kedareswara.rao@amd.com>
 <77e8433f-6cb8-eb32-63d5-414a92d3b874@linaro.org>
 <f45fccec-4496-19af-0e14-bd626e14c7bd@amd.com>
 <bc99e06b-1aa5-441e-c86f-0fbfb0945d0c@linaro.org>
 <259a1808-934b-359c-a95f-50d654a48816@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <259a1808-934b-359c-a95f-50d654a48816@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 14:09, Michal Simek wrote:
>> Similarly when you change jobs while resending your patch - you do not
>> add new SoB but just keep SoB from @previous-company.com.
> 
> IMHO That would be more questionable when you create changes in origin series 
> and new employer pays you to do the work.

True, when changes happen in between, it gets tricky.

> If it is 3rd party company picking series where upstreaming is not finished you 
> will expect that 3rd party will add their sob lines there too.

Of course, because this is different person. The SoB comes always from a
person, although he might represent company.

Best regards,
Krzysztof
