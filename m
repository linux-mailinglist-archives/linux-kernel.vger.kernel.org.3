Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1E9585631
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbiG2Uee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiG2Ued (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:34:33 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794118B4A3;
        Fri, 29 Jul 2022 13:34:32 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d3so5578717pls.4;
        Fri, 29 Jul 2022 13:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lz+voYShqwJWZIveEgi3l00fmU3XjgscqfYAMdEVMmo=;
        b=St1dOrKGvrCi1DWJbDeCfQWZKQwzgVNCLZ1znIsFlefIe3IR/7MVghOR0fqEMufsv3
         DctIe++hxSQH8cLrfShT3eRgUzrTmEo8+rJaiFenP4OpalpzR0BIhrDlkx1RkAVR/JWk
         rllCjPYVLpLiULkI+8aW5oB8uaTvPydqeJ6fKbQO0gQE/CpRe7nEH4Ti5t3q+CDuodrG
         IWrnZBFgJ1JdHYMl/aNx3uz3s0fGivm0eHzjH/GW6IgpBPA5qbAUyngXQSqUw0hh0yiZ
         EDmTseD6xnrsZ7lHAdxQkk4FA5O07vwWFV/GGxxT9JPYATGhaOJpi1Zmk3dDRw6Mj4tC
         xHXA==
X-Gm-Message-State: ACgBeo257J/siNqF8ZsHs2aDLx9WoMc5WPgztGeLpXsHIi7I1hD9mve2
        TaTA/6cWmzfPNubXkRuDB7s=
X-Google-Smtp-Source: AA6agR7J2FkHfNF3gFH7yKEiPgfip/m0kbVNYXdxZpZ2UlP74Y04blSBHbSl8mrQ9RAT9w/XfGN3qw==
X-Received: by 2002:a17:902:e80b:b0:16d:67a9:36a2 with SMTP id u11-20020a170902e80b00b0016d67a936a2mr5560850plg.144.1659126871883;
        Fri, 29 Jul 2022 13:34:31 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f090:7a49:3465:6a5? ([2620:15c:211:201:f090:7a49:3465:6a5])
        by smtp.gmail.com with ESMTPSA id ik2-20020a170902ab0200b0016d7b2352desm4055555plb.244.2022.07.29.13.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 13:34:31 -0700 (PDT)
Message-ID: <0fccbbcf-2eb0-56b0-8334-0952a03308b3@acm.org>
Date:   Fri, 29 Jul 2022 13:34:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 5/6] scsi: ufs: wb: Modify messages
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220729045656epcms2p1e6912ae09ca2122d4d04854878e19b2c@epcms2p1>
 <20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce@epcms2p4>
 <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
 <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
 <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
 <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p4>
 <20220729045756epcms2p40a1baa2c6bf17772023ccec20aef3f0a@epcms2p4>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220729045756epcms2p40a1baa2c6bf17772023ccec20aef3f0a@epcms2p4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 21:57, Jinyoung CHOI wrote:
>   	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
>   	if (ret) {
> -		dev_err(hba->dev, "%s Write Booster %s failed %d\n",
> +		dev_err(hba->dev, "%s: Write Booster %s failed %d\n",
>   			__func__, enable ? "enable" : "disable", ret);
>   		return ret;
>   	}

Please also fix the grammar (enable -> enabling; disable -> disabling).

Otherwise this patch looks good to me.

Thanks,

Bart.
