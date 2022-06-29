Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448A35608C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiF2SNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiF2SNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:13:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1201E3E7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:13:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z41so4775961ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NQV1i59mi4tYuil98CU1c0W6/nHmMnM5HHghJrHgau4=;
        b=WNrFF9D7t/NeKPR2o263ccrZ4Kz2RDLA8sOsIoouM761+1rrT4cof++hldliKQiACV
         hX3LySXE+ZSE33jC5CfHMcwYfym4jCLhPhtxseUmO7PgYE32cye9xBIOUfkh8pGoVVn2
         krpgMJIqN+nxTOwpLj81I/uVydhVfoX2aSdell54CqeaGcqlDF7JPRWUBeC3hljz4Mzd
         Ht+WZST6eV3cstYTNkXHep5D2gHL69WuPvHk2fRl1vThyAY5dF/d4mdQi0ISy7btrG2t
         vfUnzuE/CkJ9gA6SA9GS0tu5tEBmTYfo0nwwsAHxEmXl+mGMkzStu+7B4CnpxDDtoTEl
         UCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NQV1i59mi4tYuil98CU1c0W6/nHmMnM5HHghJrHgau4=;
        b=4InVJeM+hJTssp41MwBbA8dt9QgcGAJypdSzRYXtR0g85yh7bSLPgdK5VktaVSk+Hm
         yNWHPPXTkMgDrViw9XWcFBGprbbrPWAS4XBbj63DCXeyd6sPT5ut/oMAUo6wfNz1BLJc
         alNnDDXi0U2MYH5kbfWEGK/CsVE45gF6UQjefsAI9PfrBGg08Gx3uJ+dtziBhlcM3nTq
         zzCIwq4tOM+uYdPm/+XuYgSUmbdKb7BCb/2PFd3jXcYr5tvV5QjcDp0V7FBmSnORz33R
         2tcGODtz9kqGvOJmZ45kLxVYh4Ewd4WNN/uiqELlPCB5RNkBVI+29QfSNNh9+GYkv22w
         xoug==
X-Gm-Message-State: AJIora/3MTNJ+OO4a8RjZVNUnE6V9Znyv2Y6pJq8RTcfLn5wq24IEkio
        0mvqiJ8/SfsVjoLAcFbWLPFmyA==
X-Google-Smtp-Source: AGRyM1vDnN5C5nuEB9Dh4LeQO94kOMTOgN6sZ3SPGH517QZb1tU5e/c3+vjlciBP8Wf5FDroAz1iKQ==
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id ew4-20020a056402538400b004316d84b451mr5899111edb.46.1656526395107;
        Wed, 29 Jun 2022 11:13:15 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id zm9-20020a170906994900b006fee7b5dff2sm8127702ejb.143.2022.06.29.11.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:13:14 -0700 (PDT)
Message-ID: <908e7555-0090-84fe-4227-d6b349de1394@linaro.org>
Date:   Wed, 29 Jun 2022 20:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 02/12] powerpc: wiiu: device tree
Content-Language: en-US
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Ash Logan <ash@heyquark.com>, krzysztof.kozlowski+dt@linaro.org,
        paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org,
        devicetree@vger.kernel.org, linkmauve@linkmauve.fr,
        linux-kernel@vger.kernel.org, rw-r-r-0644@protonmail.com,
        joel@jms.id.au, linuxppc-dev@lists.ozlabs.org, j.ne@posteo.net
References: <20220622131037.57604-1-ash@heyquark.com>
 <20220628133144.142185-1-ash@heyquark.com>
 <20220628133144.142185-3-ash@heyquark.com>
 <c760e444-57c3-0e1a-0e4d-f79d6ae9867a@linaro.org>
 <20220629161302.GG25951@gate.crashing.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629161302.GG25951@gate.crashing.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2022 18:13, Segher Boessenkool wrote:
> On Wed, Jun 29, 2022 at 11:58:18AM +0200, Krzysztof Kozlowski wrote:
>> On 28/06/2022 15:31, Ash Logan wrote:
>>> +	model = "nintendo,wiiu";
>>
>> It's not compatible, but user-visible string, e.g. "Nintendo Wii U"
> 
> The "model" property in OF is documented as:
> 
> ---
> “model”                                                                S
> Standard property name to define a manufacturer’s model number.
> 
> prop-encoded-array:
>   Text string, encoded with encode-string.
> A manufacturer-dependent string that generally specifies the model name
> and number (including revision level) for this device. The format of the
> text string is arbitrary, although in conventional usage the string
> begins with the name of the device’s manufacturer as with the “name”
> property.
> Although there is no standard interpretation for the value of the
> “model” property, a specific device driver might use it to learn, for
> instance, the revision level of its particular device.
> 
> See also: property, model.
> 
> Used as: " XYZCO,1416-02" encode-string " model" property

Hm, surprising to duplicate the compatible, but OK.

> ---
> 
>>> +	cpus {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		/* TODO: Add SMP */
>>> +		PowerPC,espresso@0 {
>>
>> Node name should be generic, so "cpu". Unless something needs the
>> specific node name?
> 
> This is how most other PowerPC firmwares do it.  The PowerPC processor
> binding is older than the generic naming practice, so CPU nodes have
> device_type "cpu" instead.  

ePAPR 1.0 from 2008 explicitly asks for generic node names. So 4 years
before Nintento Wii U. Maybe earlier ePAPR-s were also asking for this,
no clue, don't have them.

> This is a required property btw, with that
> value.  (There is no requirement on the names of the CPU nodes).

That's fine, I am not talking about property.

> There is no added value in generic naming for CPU nodes anyway, since
> you just find them as the children of the "/cpus" node :-)

There is because you might have there caches. It also makes code easier
to read.

Best regards,
Krzysztof
