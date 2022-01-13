Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080EB48DE18
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 20:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiAMTXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 14:23:01 -0500
Received: from fallback24.m.smailru.net ([94.100.187.223]:34760 "EHLO
        fallback24.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229498AbiAMTXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=gL1GmaD6qRNwtzB4MqxpZp727VMOxRBZLQ4AFnWgwJw=;
        t=1642101781;x=1642707181; 
        b=EpFMpCZfudhP++rSgE3aJDgCMo0OwyQNEnIWRMuvGF3pzXQOOg3PXgcrAtPFZ7/H4ORqXzH2gumm79j1TpSEgIGS/GxaH285a8D5TjXITV3dBITha+R+gFdzwbag3WNNi32u9nSLgNR/ozmuC8W3L4YFxyLYmuSydFrYMKbOPvU=;
Received: from [10.161.100.15] (port=41624 helo=smtpng3.i.mail.ru)
        by fallback24.m.smailru.net with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1n85gY-0001jv-Ke
        for linux-kernel@vger.kernel.org; Thu, 13 Jan 2022 22:22:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=gL1GmaD6qRNwtzB4MqxpZp727VMOxRBZLQ4AFnWgwJw=;
        t=1642101778;x=1642707178; 
        b=i36qfSkTX0m9RZXOP2IHwiw2Ls/WltlHccGt/FV4SZ0KzAIK4C+ei19E32NbA8NdWzCIf2s4WdpwgRXZwTqRwLQERYzcN6rkOC9zi8WWhDL+dvQ+05kovQPyqLcBjlxFONuFkdm5xWf81jqg8oU/AswgaqBcRbl5RcSimdDW78apT/x23cJNKDoTzD9mumaNbOvlyJHkt68b/LXFeXS9umDnW9uJRo70TtvE66CtElq3BWQpm2USiT2Wdm5htJJO9UB58DdweC8mXmENZ/eGQ5bmO2JTTRhrmYtbuYwBhk0YtUoH3HlXiZDwIUmy383QZLcCRq1/tO+sE6Uo+zP09A==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1n85gP-0002S6-KH; Thu, 13 Jan 2022 22:22:50 +0300
Message-ID: <465667bc-039e-7acb-69df-82ab811f767c@inbox.ru>
Date:   Thu, 13 Jan 2022 22:22:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Error: arch/powerpc/boot/dts/fsl/t1040rdb.dts:112.1-9 syntax
 error
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Maxim Kiselev <bigunclemax@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202201140142.ayjm3jMQ-lkp@intel.com>
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <202201140142.ayjm3jMQ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9CD668969C51240A483C19EF8315A6FF9F5BDF9E6004E426E182A05F538085040FF215B3376D938F5275ECEE2B6A4DF0E82569EE8B35D013814DBF683B7A898FA
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AD2F2D6F6013FF7FC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE76D34FAA3D8B315888F08D7030A58E5AD1A62830130A00468AEEEE3FBA3A834EE7353EFBB55337566BF0E6906D4BA60DF01D77C13737A21A3C6A25865599175141DF9E95F17B0083B26EA987F6312C9EC9ECD01F8117BC8BEA471835C12D1D9774AD6D5ED66289B5259CC434672EE6371117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658359CC434672EE6371117882F4460429728AD0CFFFB425014E868A13BD56FB6657E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637C970FD8DF19C51D2EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A56096F9FC9691053B6E53BCAF425A577F9B93734F2771D24DD59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA75B2BCE648A2EED0D6410CA545F18667F91A7EA1CDA0B5A7A0
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34A150564C13026C186A8FF1272B3C0869725DABDC638704CF3053A08C60DFF09FCF7A45017CCB640D1D7E09C32AA3244C10D1B50BC7059CDB31CAA7348E2D3AD03A92A9747B6CC886927AC6DF5659F194
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojieoUMt/u5LhAl7y51Z9KzQ==
X-Mailru-Sender: 689FA8AB762F739339CABD9B3CA9A7D620BF9579964985C0758572B88246BBF298CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: 6242723A09DB00B4297D9AD4AAE60BCBA607DD4262E39E450FE39EB0BE1E70DD049FFFDB7839CE9EC1D1B318120D63ABCE7DED9303F687028EB789755F156B2BA12DF4A48189C04B
X-7FA49CB5: 0D63561A33F958A57E80E6ACFA05765909F3843522FD0890A4C439FBA7869F48CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637C3E95B63A1FCE889389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8EE16715F795C715CF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7D699F3A2029486C7731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A57E80E6ACFA05765909F3843522FD0890B15E3FB023FD77EBD59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojieoUMt/u5Ljpn3O1u5mZPg==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.01.2022 20:53, kernel test robot wrote:
> tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220112-013848/Maxim-Kiselev/powerpc-dts-t1040rdb-fix-ports-names-for-Seville-Ethernet-switch/20211230-184411
> head:   50f019b2ff409796f96cd749ecd816ff18575d8b
> commit: 50f019b2ff409796f96cd749ecd816ff18575d8b powerpc: dts: t1040rdb: fix ports names for Seville Ethernet switch
> date:   2 days ago
> config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220114/202201140142.ayjm3jMQ-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/50f019b2ff409796f96cd749ecd816ff18575d8b
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review UPDATE-20220112-013848/Maxim-Kiselev/powerpc-dts-t1040rdb-fix-ports-names-for-Seville-Ethernet-switch/20211230-184411
>          git checkout 50f019b2ff409796f96cd749ecd816ff18575d8b
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: arch/powerpc/boot/dts/fsl/t1040rdb.dts:112.1-9 syntax error
>     FATAL ERROR: Unable to parse input tree
This is very strange error. Submitted patch doesn't touch string 112.
String 112 is #include "t1040si-post.dtsi"

> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
