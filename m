Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ABD5362F9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbiE0Msv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbiE0Mso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:48:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5E717AB3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:48:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id fd25so5287830edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EM3junmIgJL5MDcB8Fbmsce/dgWKtd82JnNvIdb7NL8=;
        b=eGiykh9/rX5xSkjr0lGcfXZu+d4t3VHbBqxcAehu2XlVx77qDA9fii87Gaqg4BovwF
         /RHqdnGa8ywYUNljIM01Hn212qpYdPFlt6waO1DZ5rqlDKn42bVSXd2yl7JuieYdn3X2
         gc5nGdPXpo6LTWsQJoZhrKemLegV+sfTnBc9kTDlJsuTyrKT7Z4anLDU8fGs3SblRutB
         mT/fk+3Ubjfmz/lazij7GveaBbSrNwYA29O5XenDFuvKJouUJLDiDEjSFVfIR2PUBEl/
         +9HsVTTLhI3tgFv63fA2+9d5kLr8MxAyDARwjOXdByG6Jb72J4AzXlDR12N+sf90vKz1
         dutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EM3junmIgJL5MDcB8Fbmsce/dgWKtd82JnNvIdb7NL8=;
        b=Yh04R3Y1TThgI5wFb0QORw/LKNENS3H/Ty7kFCKi2k0+kB0XfeS1P+F2Zfnc7MVoNa
         7+24Tdq3zc2bJJVN/Dh0l4YAcJ/W6wEHZihJ/56NbRK8SvPecVDLKdrL1Mse8TlcdvSo
         deVvDrpVTrH4oVMMlEcD2H5UR4HZtZcJUpOkkKpqHWgfDEc0F/jam3v30t25FbkYJ53J
         5SatBIT3furL3kSrUtWKvpyyCRC1ykhDaQbAY6hWt3+V/58QNjwGyRNo9O8t12ZRF40N
         jTMejYEm1gX126K883+PeHQZomVS4Xd1GxqBgoFQNrNgKhVEnhzLB5hPt1C9+Ifh2SyS
         wjlA==
X-Gm-Message-State: AOAM530/S9dfarm5WOJSgP5GBqNtZVnUaH9KJe4dsgVMt6umpcw2iGUp
        pyY4ARFkYJvZormvJCTAFCAu5A==
X-Google-Smtp-Source: ABdhPJyZE0mb3YQcfGmYAgiLZNdhvEbEh3SU0kWPxJgZcq0vLyj2VUCjJO+GQ5nHhfWrVn4RSjuN0g==
X-Received: by 2002:a05:6402:160b:b0:42c:1f6d:2fbf with SMTP id f11-20020a056402160b00b0042c1f6d2fbfmr1347111edv.59.1653655718726;
        Fri, 27 May 2022 05:48:38 -0700 (PDT)
Received: from [192.168.133.234] (92.40.183.95.threembb.co.uk. [92.40.183.95])
        by smtp.gmail.com with ESMTPSA id m7-20020a17090679c700b006fec69696a0sm1427105ejo.220.2022.05.27.05.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 05:48:38 -0700 (PDT)
Message-ID: <a7f46ad1-6d9e-a38e-31cc-29fddfa2b496@linaro.org>
Date:   Fri, 27 May 2022 13:50:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: RE: [RESEND PATCH] scsi: ufs: sysfs: support writing boot_lun
 attr
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        "a5b6@riseup.net" <a5b6@riseup.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>
References: <20220525164013.93748-1-a5b6@riseup.net>
 <DM6PR04MB65750969ACD36EEEB48374DFFCD69@DM6PR04MB6575.namprd04.prod.outlook.com>
 <8d25171a-5d86-9acc-0f94-1a3c6efdb360@riseup.net>
 <DM6PR04MB65752422396C86EAD4591701FCD89@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <DM6PR04MB65752422396C86EAD4591701FCD89@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/05/2022 07:17, Avri Altman wrote:
>>
>> Hi,
>>
>> My usecase is enabling boot slot switching on Android A/B devices, where the
>> active LUN has to be changed in order to facilitate e.g. dual-booting Android
>> and mainline Linux. A similar interface is exposed by Android, albeit via ioctl. I've
>> tested this patch and confirmed it enabled the necessary functionality.
>>
>> On 25/05/2022 21:34, Avri Altman wrote:
>>> Hi,
>>>> Expands sysfs boot_lun attribute to be writable. Necessary to enable
>>>> proper support for LUN switching on some UFS devices.
>>> Can you please elaborate why is it necessary?
>>> What use case are you running?
> NAK with prejudice.
Hi Avri,

Could you explain why the NAK here? Boot LUN switching is used on a lot 
of embedded devices to implement A/B updates, Android devices are just 
one such example.

Distributions like postmarketOS [1] aim to support upstream Linux on 
mobile devices, particularly those that are no longer supported by the 
vendor. Being able to make use of features like A/B updates is something 
that I expect more distributions to be considering in the future, as we 
start to see more Linux devices with support for features like this.

If safety is a concern, or if the values are device specific, we can 
look at protecting the write functionality and configuration behind DT 
properties, or coming up with another alternative.

[1]: https://postmarketos.org

Kind regards,
Caleb (they/he)

> 
> Thanks,
> Avri
> 
>>>
>>>> Signed-off-by: Nia Espera <a5b6@riseup.net>
>>>> ---
>>>>    drivers/scsi/ufs/ufs-sysfs.c | 67 +++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 66 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/scsi/ufs/ufs-sysfs.c
>>>> b/drivers/scsi/ufs/ufs-sysfs.c index 5c405ff7b6ea..7bf5d6c3d0ec
>>>> 100644
>>>> --- a/drivers/scsi/ufs/ufs-sysfs.c
>>>> +++ b/drivers/scsi/ufs/ufs-sysfs.c
>>>> @@ -1047,6 +1047,71 @@ static inline bool ufshcd_is_wb_attrs(enum
>>>> attr_idn
>>>> idn)
>>>>                   idn <= QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE;
>>>>    }
>>>>
>>>> +static ssize_t boot_lun_enabled_show(struct device *dev,
>>>> +                                    struct device_attribute *attr,
>>>> +char *buf) {
>>>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>>>> +       u32 slot;
>>>> +       int ret;
>>>> +       u8 index = 0;
>>>> +
>>>> +       down(&hba->host_sem);
>>>> +       if (!ufshcd_is_user_access_allowed(hba)) {
>>>> +               up(&hba->host_sem);
>>>> +               return -EBUSY;
>>>> +       }
>>>> +       if (ufshcd_is_wb_attrs(QUERY_ATTR_IDN_BOOT_LU_EN))
>>> Clearly bBootLunEn is not a WB attribute.
>>>
>>>> +               index = ufshcd_wb_get_query_index(hba);
>>>> +       ufshcd_rpm_get_sync(hba);
>>>> +
>>>> +       ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
>>>> +               QUERY_ATTR_IDN_BOOT_LU_EN, index, 0, &slot);
>>>> +
>>>> +       ufshcd_rpm_put_sync(hba);
>>>> +       if (ret) {
>>>> +               ret = -EINVAL;
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       ret = sysfs_emit(buf, "0x%08X\n", slot);
>>>> +out:
>>>> +       up(&hba->host_sem);
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +static ssize_t boot_lun_enabled_store(struct device *dev,
>>>> +                                     struct device_attribute *attr,
>>>> +                                     const char *buf, size_t count)
>>>> +{
>>>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>>>> +       u32 slot;
>>>> +       int ret;
>>>> +       u8 index = 0;
>>>> +
>>>> +       if (kstrtouint(buf, 0, &slot) < 0)
>>>> +               return -EINVAL;
>>> You need to verify that no one set bBootLunEn = 0x0 because the device won't
>> boot.
>>> Better check explicitly that slot != bBootLunEn and its either 1 or 2.
>>>
>>> Thanks,
>>> Avri
>>>
>>>> +
>>>> +       down(&hba->host_sem);
>>>> +       if (!ufshcd_is_user_access_allowed(hba)) {
>>>> +               up(&hba->host_sem);
>>>> +               return -EBUSY;
>>>> +       }
>>>> +       if (ufshcd_is_wb_attrs(QUERY_ATTR_IDN_BOOT_LU_EN))
>>>> +               index = ufshcd_wb_get_query_index(hba);
>>>> +       ufshcd_rpm_get_sync(hba);
>>>> +
>>>> +       ret = ufshcd_query_attr_retry(hba,
>> UPIU_QUERY_OPCODE_WRITE_ATTR,
>>>> +                                     QUERY_ATTR_IDN_BOOT_LU_EN, index, 0, &slot);
>>>> +       ufshcd_rpm_put_sync(hba);
>>>> +       if (ret) {
>>>> +               ret = -EINVAL;
>>>> +               goto out;
>>>> +       }
>>>> +out:
>>>> +       up(&hba->host_sem);
>>>> +       return ret ? ret : count;
>>>> +}
>>>> +
>>>>    #define UFS_ATTRIBUTE(_name, _uname)                                   \
>>>>    static ssize_t _name##_show(struct device *dev,                                \
>>>>           struct device_attribute *attr, char *buf)                       \
>>>> @@ -1077,8 +1142,8 @@ out:                                                                      \
>>>>           return ret;                                                     \
>>>>    }                                                                      \
>>>>    static DEVICE_ATTR_RO(_name)
>>>> +static DEVICE_ATTR_RW(boot_lun_enabled);
>>>>
>>>> -UFS_ATTRIBUTE(boot_lun_enabled, _BOOT_LU_EN);
>>>>    UFS_ATTRIBUTE(max_data_size_hpb_single_cmd,
>> _MAX_HPB_SINGLE_CMD);
>>>>    UFS_ATTRIBUTE(current_power_mode, _POWER_MODE);
>>>>    UFS_ATTRIBUTE(active_icc_level, _ACTIVE_ICC_LVL);
>>>> --
>>>> 2.36.1
