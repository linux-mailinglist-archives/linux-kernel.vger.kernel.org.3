Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5B462B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbhK3ENR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhK3ENQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:13:16 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D66C061574;
        Mon, 29 Nov 2021 20:09:58 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id l190so18325685pge.7;
        Mon, 29 Nov 2021 20:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nEIX/j0lmp909rKkI10pcE3qIKIHSFZWDDUw23di01U=;
        b=CwKULsikp2AkJY/2k4NHZs90RbIU7FcASovafFccxJUX1yZdbkdtCi0gFiI5Z0HmtV
         f1BMaovcJQYNS7VTC5JGyZY/0vAhToG2nFuPqKbsn6yL3f3IDNtCXQmPwWjhhw5r+TsS
         dgxifDT6SG0NbpdDnj3zA52zLrHIgsP8IrH9cWmcztmeYOobQtph1Q2obirgOPFe6AG1
         L3HXB+N19ga/+rz8/XK5HNIh9nRoaOBR+6rovp4z/uYe55zky+xJm4s87bEmLH5QB2ZG
         V311pnciXCNU6EdsXGIDXigYXZsHv1gfzMMWMjl3lJg2ysST8Cgd3GF8u+DuYblr/Xt3
         izjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nEIX/j0lmp909rKkI10pcE3qIKIHSFZWDDUw23di01U=;
        b=h6+2BYmibzctbmktmh2lWmoDxd/m7Lz1VDR9eDbYSLpfxtTFG/9VH7eJy5v77vFSi+
         TdU7OkUKrHDaHDL+/DLA/1YJEw6kpxjU4eNMC9vmlK/8gXRPd6wFXFg9+FZlBzo53ms8
         zMkBIlGcNcAoub+9Juj59WIj9U1JwwfoBPtEswpmiFr1bfa/gU7HChJEuCYj9pIUuV7D
         mP8gS0ddBi3XEq73IijaaAmQV6CHD0lsMByzWcuLiXU9sGfhBnQ4C8Hf82LtJOVLOdsn
         S5ZHEjZk4FKSSDtxKizTpvIIWPG5dwrrc9qaFOdVUoPzSc+fA/+9kAKjaoaLlOxR6XM9
         psSA==
X-Gm-Message-State: AOAM531anXCYznf6In741TOdKS1Winn/OEbAn2QiI4z8kzSYMyeVMrl/
        gcZJXB5v3qRTReQwpC/vGhc=
X-Google-Smtp-Source: ABdhPJyz7aFUhs8gqu4s341YjhXxM9ismwU/x7es8LNtOWznnTYJSOBV3sLo/4HsUGLvI4NkNv1gAA==
X-Received: by 2002:a63:d054:: with SMTP id s20mr9698400pgi.565.1638245397805;
        Mon, 29 Nov 2021 20:09:57 -0800 (PST)
Received: from [10.230.1.174] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 17sm13097543pgs.92.2021.11.29.20.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 20:09:56 -0800 (PST)
Message-ID: <4a61707b-a82b-4950-88b3-5f268d9fc92c@gmail.com>
Date:   Mon, 29 Nov 2021 20:09:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/2] scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT formatting
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "supporter:QLOGIC QL41xxx ISCSI DRIVER" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:QLOGIC QL41xxx ISCSI DRIVER" <linux-scsi@vger.kernel.org>
References: <20211126201708.27140-1-f.fainelli@gmail.com>
 <20211126201708.27140-3-f.fainelli@gmail.com>
 <yq1fsrez4cn.fsf@ca-mkp.ca.oracle.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <yq1fsrez4cn.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/2021 7:59 PM, Martin K. Petersen wrote:
> 
> Florian,
> 
>> The format used for formatting SYSFS_FLAG_FW_SEL_BOOT creates the
>> following warning:
>>
>> drivers/scsi/qedi/qedi_main.c:2259:35: warning: format specifies type
>> 'char' but the argument has type 'int' [-Wformat]
>>                     rc = snprintf(buf, 3, "%hhd\n",
>> SYSFS_FLAG_FW_SEL_BOOT);
>>
>> Fix this to cast the constant as an u8 since the intention is to print
>> it via sysfs as a byte.
> 
> The other occurrences of SYSFS_FLAG_FW_SEL_BOOT use "%d". Since %hh is
> deprecated I suggest you just fix the snprintf().

That was what v1 did here:

https://lkml.org/lkml/2021/11/26/9

however Manish seemed to want that flag to be printed as a byte I am 
fine either way.
-- 
Florian
