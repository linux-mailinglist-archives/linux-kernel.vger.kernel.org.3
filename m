Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4774BBC74
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbiBRPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:49:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiBRPs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:48:27 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E9C275AD3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:47:47 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id m185so7989227iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0d+ENbVi/YpblJNfRhmkBPMtWMK0eYnnrjx3M98By1Q=;
        b=iSzm9e9rhgQdjya/dXkRvAM1FpOkM7gQVMGxVGb2x1Y4goZHEdAoK2B9HxrblJG4pO
         6wf6/kKjkJtiISXXLCHwzlpVKNoAPwhYEAYu+mPgoa2BvPLoJO7yTR2zYtPDUCqWAUEy
         N48CXZ0HChG5SH0ZIL5VnwzVvgZ9GIlevIoprkPkXl5mx2XSmkhVJWPlhld6nWFEo+/J
         +hkfWO2MHK6Rqd2hZ+YCH+eIWG4CR8/KnQG7OaEOpnERc0DH6Bg6qUfusAvUqTv4iAOz
         XPFjiOXk8YeQfwOZW2tfENayg5tdXx0HCC6mZrQB7p+W85ysXB/3elBm+s+DNC5YF4MH
         PHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0d+ENbVi/YpblJNfRhmkBPMtWMK0eYnnrjx3M98By1Q=;
        b=27ifEOC9QlxAZ7M6fTnJfTLqo3oA/TJvhORFf3wa6Tglx36AUjiT3n7ThZit3DTWzD
         nPUMjWaS7V8+zyU8MoJ254ZBgaYeIEGBAhWqaJ9s2LCKwsgJ8OJUmpYz+ENl3qMrLpaK
         S2YNxXs68Fe2ETgswmkLWKW68oc6N7m3qB8crwKxpcvEVwgw2JFuQ9XF/uyeoBgCiujp
         +NbHWLbRqWPDuYqFgODhaCfv+hD0+6qZ/qNoe9zpAChX722Ap9i9HsDaCphMg3Cp4LEA
         At1NpcoQPSes/UmsUesnS51bNPBnDtDlh4wJvyKJhnqnioGz4WF5Qv94gOFlaLPvPz4h
         Cl2w==
X-Gm-Message-State: AOAM531cSU2LKQng/pHQCcQDmGqVfebbBbRTy+lM7mHog3Zm3dtB+D2f
        SHHXSDvA2qbiFbthlThSYGB4yQ==
X-Google-Smtp-Source: ABdhPJwHpswjOEoA8nxD3wFPtsUtlFlgSNXvQOMW/OrH5MyURG9TSAVfOrvj6jF1aUyljKqJYuYP6Q==
X-Received: by 2002:a05:6638:168b:b0:314:7a8d:19d4 with SMTP id f11-20020a056638168b00b003147a8d19d4mr5936881jat.199.1645199266560;
        Fri, 18 Feb 2022 07:47:46 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f10sm3550646ilj.73.2022.02.18.07.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 07:47:46 -0800 (PST)
Message-ID: <e516d27b-922a-dbbe-e0da-143eb2ab31d8@linaro.org>
Date:   Fri, 18 Feb 2022 09:47:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 12/25] bus: mhi: ep: Add support for ring management
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-13-manivannan.sadhasivam@linaro.org>
 <20504c14-6df5-83d1-53e9-85c682a5a3c7@linaro.org>
 <20220218080704.GD11964@workstation> <20220218152327.GA11639@thinkpad>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220218152327.GA11639@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 9:23 AM, Manivannan Sadhasivam wrote:
>>>
>>> I'm pretty sure I mentioned this before...  I don't really like these
>>> "DWORD" macros that simply write compute register values to write
>>> out to the TREs.  A TRE is a structure, not a set of registers.  And
>>> a whole TRE can be written or read in a single ARM instruction in
>>> some cases--but most likely you need to define it as a structure
>>> for that to happen.
>>>
>>> struct mhi_tre {
>>> 	__le64 addr;
>>> 	__le16 len_opcode
>>> 	__le16 reserved;
>>> 	__le32 flags;
>>> };
>> Changing the TRE structure requires changes to both host and endpoint
>> stack. So I'll tackle this as an improvement later.
>>
>> Added to TODO list.
> Just did a comparision w/ IPA code and I convinced myself that this conversion
> should happen now itself. So please ignore my above comment.

This might not be that much work, but if it is, I somewhat
apologize for that.  Still, I believe the code will be better
as a result, so I'm not *that* sorry.

If you do this though, I would recommend you do it as a
separate, prerequisite bit of work.  Your series is too
long, and making it longer by adding this will just delay
*everything* a bit more.  So, I'd advise updating the
existing host code this way first, then adapt your patch
series to do things the new way.

Alternatively, do this later (as you earlier said you would),
and don't delay this series any more.  If it works, it works,
and you can always improve it in the future.

And now that your series is getting closer to golden, maybe
you can break it into a few smaller series?  I don't know,
that also can lead to some confusion, so I won't strongly
advocate that.  But it's something to consider for future
work regardless.

					-Alex
