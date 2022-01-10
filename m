Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D908A489DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbiAJQjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbiAJQji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:39:38 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C863DC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 08:39:38 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id oa15so13218751pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 08:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Jg4jmTbD3eHzMlZt+T+Mw7SGeOkM/SAyjyO1r35dWg=;
        b=Oe6vL3o8xeI6T80YuOFuDQHVzD3yowpB7LnCM/cz/laAj73/xa0fvML8tNtStwmUqm
         XrSBq4C9NeKnTZ3QDrt1fd9U/ieVrckyoLxjyw8P36k6gXozytdhCQkgwxtWsvhKTMBR
         r5QCJdq2bekwtJXoEKiIR54oBpVTWNviThaJnj8mAVsuD85p7qRRVRI8FsvMNLx/q8E3
         wbbGoQQh5uJTaAAsFXXEL0bfjnSbkimm3Hp1BHlNyIUZWXVMJ9vYSCdRPuqjOktS4nTR
         UAL6kq212FIhH/9AhZTjNUrIt5On0WzxcrKK6T9yemLHsNagaOGonPu29D/69NNmQQ/F
         PlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Jg4jmTbD3eHzMlZt+T+Mw7SGeOkM/SAyjyO1r35dWg=;
        b=5cPTx57gB3aLcuUCk5jxfgxOmwvFcFb+/JRwvU4zfXI5jpHN+cqc7x5X9LdZjr6G5j
         V04UPjed/nZGUb/LrSgZEohNe4aYuipGJ0qz5UhDDMfPL9VgnGVMc/1wcy2JEuwuoG/E
         vT07Tmj0d8I+WgQyg6wVqUAWrl57w25AHKu8mDTWdwssL78uzWd/C3mDHEicWbYM6Af0
         Cj+WYDlXmmxVhLWMGDnF8vW3SWOALHm5n23ONxaiFO2gS7sDmzd8VCVvALyimHpRG8R3
         CkHoVpBv3z5znIZAJ3P0g5szIxXzZl7ocVhVg5NRyU0QQe1kiIxWMnL6rJwCL30LMnZV
         yYcA==
X-Gm-Message-State: AOAM531n3C9WqVcBEqKxF7d57s917MZ076ms1FUjcttzGmIuXGLBoNmC
        +CMFErz9hWq5ZxNVuFZMvlA=
X-Google-Smtp-Source: ABdhPJyzE5X/G7q5Gib/WOXInZm3xvhg/39L17HCNkohZF0cMXCqurzAE9rwIPSmkNEPo+uHwcaigQ==
X-Received: by 2002:aa7:9098:0:b0:4bd:65b5:fcf3 with SMTP id i24-20020aa79098000000b004bd65b5fcf3mr365080pfa.72.1641832778337;
        Mon, 10 Jan 2022 08:39:38 -0800 (PST)
Received: from [192.168.1.26] (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id j8sm6027602pgf.21.2022.01.10.08.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 08:39:38 -0800 (PST)
Message-ID: <39a00fdf-e6fd-f421-ccc5-73aec33595e1@gmail.com>
Date:   Mon, 10 Jan 2022 08:39:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [mkp-scsi:for-next 67/132] drivers/scsi/elx/libefc/efc_els.c:73
 efc_els_io_alloc_size() warn: sleeping in atomic context
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <202201082354.iAG3UuiL-lkp@intel.com>
 <20220110071104.GA625@lst.de>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220110071104.GA625@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/2022 11:11 PM, Christoph Hellwig wrote:
> So while this warning is correct, it is not new.  GFP_DMA can sleep
> just like GFP_KERNEL. Someone was already trying to give this a spin
> on the linux-scsi list, but we really need maintainer helper here.

Yep - I'll go look at it.

-- james
