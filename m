Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1394F86D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346733AbiDGSEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343571AbiDGSEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:04:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681A1BD895
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:02:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m30so9073753wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZI2zq9mkd2prXmULME2LtrcZkY8ywRvQtGF9At1AEMM=;
        b=liamQE/kdVhSCuAi5OWNzVoQ3g4xNM16YZqC0W7s0Aq7ZJNeiP06CAqHQ+hSc4MVM6
         UjOOz1zh1WxpOU+yHJEZoS4DAbmODPzE84f8QLMP3ZkUON9vU3JglbB/Zvg2m91ibbbP
         Uqt/5ENtb8hY0DuQgmMhzUXb8Tm4keng/c9bPZi9L2hfRJSSpoTbMYIQSKJd57h1BOVd
         6XUeDR4VzJcSEtAfy4v6dSJlw4gf6CrqrxQXUnfDvBjfuJQGn+etz4xcotMOCMAsCHho
         XfC+N710MMlJ1Dm9r+2+7bcYkhsLAIiDxIqVmRsuFVJ44EiYRVGxTj2vl4nivmFA7hdw
         o0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZI2zq9mkd2prXmULME2LtrcZkY8ywRvQtGF9At1AEMM=;
        b=Qp1LMUs02oHLlqcnuwsq2mXy/uR66Tf0rFVoMRgE9yL+s2TUsYo8WONtkP55wbQZcW
         o7TU81BfE5yuu7u0qfsedyZ6hRSZ8XSxaT4iEV8sBrrlCZ5ZZX6yyXf9NYLx89lUg+vX
         PsVmiQ7Ik4ZBOp6B9YlXlhMgbhx7fPwzehfDqmWChOn4iFfM1O+ufyv4N8CiHBY3Y4gp
         1RnpDOBFhOnz8qIG0XLf8Koi9x6XjsTK8rnYuPb4r9pbas6z4wiiYyqe7zrjbfbUHkLk
         jnZN0t6mmPSfIL+erR0eWaGoMTU+qlum9yJyLeekllzEIIAnh+PDnpY54IELMnJJ5cMP
         w/QA==
X-Gm-Message-State: AOAM533HL8W/nrgwQ3ZyZxL4F8om6fg4tEmoH1bx9l1CSlR3KgexxSyc
        F5Jb5HzABLeLPOJEQ9keWEU=
X-Google-Smtp-Source: ABdhPJzQka+xTNU7ql8arJI82ehOltbzm2rvGQHJA9CwS4HmmPHVaxrgpjhgiXExl+NTmFEefB9ASQ==
X-Received: by 2002:a5d:55c8:0:b0:206:f52:902e with SMTP id i8-20020a5d55c8000000b002060f52902emr11330443wrw.597.1649354558824;
        Thu, 07 Apr 2022 11:02:38 -0700 (PDT)
Received: from [192.168.1.14] ([197.57.231.245])
        by smtp.gmail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm20030480wrb.101.2022.04.07.11.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:02:38 -0700 (PDT)
Message-ID: <96a1de63-5b66-b6a6-731e-d7263f3328a5@gmail.com>
Date:   Thu, 7 Apr 2022 20:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4] staging: rtl8712: remove unnecessary parentheses
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220407125947.8525-1-eng.alaamohamedsoliman.am@gmail.com>
 <Yk8jbTSjvsHXpX2U@kroah.com>
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
In-Reply-To: <Yk8jbTSjvsHXpX2U@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ٧‏/٤‏/٢٠٢٢ ١٩:٤٦, Greg KH wrote:
> On Thu, Apr 07, 2022 at 02:59:47PM +0200, Alaa Mohamed wrote:
>> Reported by checkpatch:
>>
>> Remove unnecessary parentheses around structure field references
>>
>> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
>> ---
>> Changes in v2:
>> 	- Edit commit subject
>> 	- Edit commit message
>> 	- Fix the same check in more lines
>> 	- Remove space before '.skey' in
>> "memcpy(psta->tkiptxmickey.skey," in lines 84 and 86.
>> ---
>> Changes in v3:
>> 	return the space before '.skey' in
>> "memcpy(psta->tkiptxmickey.skey," in lines 84 and 86
>> ---
>> Changes in v4:
>> 	edit commit message to be clearer.
>> ---
> Why did you send this patch twice?
That was by mistake , sorry
>
